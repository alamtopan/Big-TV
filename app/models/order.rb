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
