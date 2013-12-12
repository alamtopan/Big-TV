class OrderItem < ActiveRecord::Base
  attr_accessible :membership_id, :quantity
  belongs_to :order
  belongs_to :membership

  with_options(numericality: {null: false, greater_than: 0}) do |numericality|
    numericality.validates :quantity
    numericality.validates :price
  end

  before_save   :before_saving
  after_destroy :after_destroy


  def membership_category
    self.membership.category.name
  end
  
  private
    def before_saving
      self.subtotal = self.price.to_i * self.quantity.to_i
      self.title = self.membership.name
    end

    def after_destroy
      order.calculate_total(:true)
    end

end

