class Order < ActiveRecord::Base
  attr_accessible :orderable_id, :orderable_type, :session_id, :items_attributes, :file_faktur
  
  has_attached_file :file_faktur, styles:  { 
                                   :medium => "600x600>", 
                                   :thumb => "100x100>" 
                                  }, 
                                  :default_url => "/assets/no-image.png"

  has_many   :items, class_name: "OrderItem", dependent: :destroy
  belongs_to :orderable, polymorphic: true
  belongs_to :user, foreign_key: 'orderable_id', conditions: "orders.orderable_type = 'User'"
  has_many   :payments

  after_update  :after_modification
  before_create :before_creation

  scope :success_order, where("session_id IS NOT NULL")

  module Status
    SUCCESS = 'success'
    FAILED  = 'failed'
    PENDING = 'pending'
  end

  CHARGE_FEE = {'04' => 0.02}

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
    def accessible_by(current_ability)
      return self if current_ability.current_user.type.blank?
      current_ability.current_user.orders
    end

    def latest_order(prefix)
      result = self
      result = result.where(code_prefix: prefix) if prefix
      result.order("position DESC").first
    end
  end

  def success_payments
    payments.where(status: Order::Status::SUCCESS)
  end

  def premium_unit_items
    premium_item = items.premium
    return [] unless premium_item
    premium_item.membership.unit_items
  end

  def grand_total
    self.total.to_i + self.charge_fee.to_i
  end

  def total_non_fee
    self.period = 1 if self.period.to_i < 1
    total_non_fee_without_period * self.period.to_i
  end

  def total_without_fee_and_period
    items.where('membership_id IS NOT NULL').sum(:subtotal)
  end

  def total_with_fee_and_non_period
    items.sum(:subtotal)
  end

  def total_with_fee
    self.period = 1 if self.period.to_i < 1
    total_with_fee_and_non_period * self.period.to_i
  end

  def calculate_total(autosave=:false)
    self.period = 1 if self.period.to_i < 1
    total_amount = items.sum(:subtotal) * (self.period||1)
    self.charge_fee = (CHARGE_FEE[self.payment_method.to_s].to_f * total_amount).ceil
    
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

  def remove_junk
    if Time.now.utc > updated_at.since(15.minutes).utc
      if items.blank? && session_id.present?
        CustomerMailer.welcome_email_admin(orderable) if orderable.present?
        destroy
      elsif success_payments.blank?
        CustomerMailer.thanks_email(self).deliver
        CustomerMailer.email_order_to_admin(self).deliver
      end
    else
      delay(run_at: 10.minutes.from_now).remove_junk 
    end
  end

  def check_activity
    if session_id.present? && !is_queue
      update_column(:is_queue, true)
      delay(run_at: 15.minutes.from_now).remove_junk 
    end
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
    basket_str = items.map{|item|
      [item.title,
       "%.2f" % item.price,
       period*item.quantity,
       "%.2f" % (period*item.quantity*item.price)
      ].join(',')
    }.join(';')
    return basket_str unless self.charge_fee.to_f > 0
    charge_fee_str = "%.2f" % self.charge_fee
    "#{basket_str};Biaya Transaksi,#{charge_fee_str},1,#{charge_fee_str}"
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
      if self.code_prefix.to_s == "0114"
        code_sufix = "%.9d" % self.position
        self.code = "1#{self.code_prefix}#{code_sufix}"
      else
        code_sufix = "%.10d" % self.position
        self.code = "#{self.code_prefix}#{code_sufix}"
      end
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
