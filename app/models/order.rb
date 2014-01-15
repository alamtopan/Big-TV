class Order < ActiveRecord::Base
  attr_accessible :orderable_id, :orderable_type, :session_id, :items_attributes

  has_many   :items, class_name: "OrderItem", dependent: :destroy
  belongs_to :orderable, polymorphic: true
  has_many   :payments

  after_update  :after_modification
  before_create :before_creation

  module Status
    SUCCESS = 'success'
    FAILED  = 'failed'
    PENDING = 'pending'
  end

 Status.constants.each do |constant|
    value = Status.const_get(constant)
    define_method("#{ value }?") do
      status == value
    end

    define_method("#{ value }!") do
      update_column(:status, value)
    end

    scope value, where(status: value)
  end

  class << self
    def latest_order(prefix)
      result = self
      result = result.where(code_prefix: prefix) if prefix
      result.order("position DESC").first
    end
  end

  def calculate_total(autosave=:false)
    total_amount = items.sum(:subtotal) * (self.period||1)

    if [:conditional, :true].include?(autosave)
      if total_amount.to_i != total || autosave == :true
        unless self.total.to_f == total_amount.to_f
          self.total = total_amount
          self.save
        end
      end
    else
      self.total = total_amount
    end
  end

  def remove_cart
    if time.now < updated_at.since(1.hour)
      if self.items.blank?
        destroy
      else
        CustomerMailer.thanks_email(self).deliver
      end
    else
      check_activity
    end if session_id.present?
  end

  def check_activity
    delay(run_at: 1.hours.from_now).remove_cart if session_id.present?
  end

  def is_order?
    orderable.present? && session_id.blank?
  end

  def add_item(item,session)
    if item.is_a?(Membership)
      populate_order_item(0, item.id,session)
    else
      return if item[:membership_ids].blank?
      item[:membership_ids].compact.uniq.each do |membership_id|
        populate_order_item(item[:quantity], membership_id,session)
      end
    end
    self.send(:before_creation)
    self.save
  end

  def populate_order_item(qty, membership_id,session)
    item = items.find_or_initialize_by_membership_id(membership_id)
    current_product = item.membership
    return false unless current_product
    
    # remove decoder if quantity is more than 1 and current package is not universe or star
    if current_product.requires_upgrade_by_decoder?(items)
      another_decoder = items.select{|i| i.decoder?}.first
      another_decoder.destroy if another_decoder
    end if current_product.premium?
    
    validate_membership(session,membership_id) if item.new_record?
    
    item.quantity = 1
    item.price = current_product.default_price
    item.title = current_product.name
    item.save
  end

  def basket
    items.map{|item|
      [item.title,
       "%.2f" % item.price,
       period*item.quantity,
       "%.2f" % (period*item.quantity*item.price)
      ].join(',')
    }.join(';')
  end

  private
    def after_modification
      check_activity
      calculate_total(:conditional)
    end

    def before_creation
      if self.code.blank?
        set_code_prefix
        set_order_position
        set_code_sufix
      end

      self.token  = Digest::SHA1.hexdigest("#{code}#{Time.now}")
      self.status = Status::PENDING if self.status.blank?
    end

    def set_code_prefix
      self.code_prefix = Date.today.strftime("%m%y") if self.code_prefix.blank?
    end

    def set_order_position
      last_order = Order.latest_order(self.code_prefix)
      self.position = last_order ? (last_order.position.to_i+1) : 1
    end

    def set_code_sufix
      code_sufix = "%.10d" % self.position
      self.code = "#{self.code_prefix}#{code_sufix}"
    end

    def validate_membership(session,membership_id)
      valid_order = Order.find_by_session_id(session)
      membership = Membership.find(membership_id)
      if membership.premium? || membership.other?
        selected_item = valid_order.items.select{|i| i.membership_category == membership.category_name}.first
        selected_item.destroy if selected_item && !selected_item.new_record?
      end if valid_order && membership
    end
end
