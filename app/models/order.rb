class Order < ActiveRecord::Base
  attr_accessible :orderable_id, :orderable_type, :session_id, :items_attributes

  has_many   :items, class_name: "OrderItem", dependent: :destroy
  belongs_to :orderable, polymorphic: true

  after_update  :after_modification
  before_update :before_modification

  class << self
    def latest_order(prefix)
      result = self
      result = result.where(code_prefix: prefix) if prefix
      result.order("position DESC").first
    end
  end

  def calculate_total(autosave=:false)
    total_amount = items.sum(:subtotal)

    if [:conditional, :true].include?(autosave)
      if total_amount.to_i != total || autosave == :true
        self.total = total_amount
        self.save
      end
    else
      self.total = total_amount
    end
  end

  def remove_cart
    if time.now < updated_at.since(1.hour)
      destroy
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

  def add_item(params)
    return if params[:membership_ids].blank?
    params[:membership_ids].each do |membership_id|
      item = items.find_or_initialize_by_membership_id(membership_id)
      current_product = item.membership
      return unless current_product
      item.quantity = (item.quantity||1).to_i + params[:quantity].to_i
      item.price = current_product.default_price
      item.title = current_product.name
      item.save
    end
    self.save
  end

  private
  def after_modification
    check_activity
    calculate_total(:conditional)
  end

  def before_modification
    if is_order? && code.blank?
      set_code_prefix and set_order_position and set_code_sufix
    end
  end

  def set_code_prefix
    self.code_prefix = Date.today.strftime("%m%y") if self.code_prefix.blank?
  end

  def set_order_position
    last_order = Order.latest_order(self.code_prefix)
    self.position = last_order ? (last_order.position.to_i+1) : 1
  end

  def set_code_sufix
    code_sufix = sprintf("%04d", self.position)
    self.code = "#{self.code_prefix}-#{code_sufix}"
  end
end
