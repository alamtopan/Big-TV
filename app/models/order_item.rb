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
    @membership_category ||= self.membership.category.name.to_s
  end

  Category::Config::NAMES.each do |val|
    define_method("#{ val.downcase }?") do
      membership_category =~ /#{val}/i
    end
  end

  def decoder?
    return false unless self.membership
    self.membership.name =~ /decoder|dekoder/i && self.other?
  end
  
  private
    def before_saving
      if self.decoder? && self.membership.name !~ /1/i
        requested_decoder = self.membership.name.gsub(/[a-z\s]/i, '').to_i
        if requested_decoder > 1
          self.subtotal = (1..requested_decoder).map do |t|
            Membership.decoder_by_quantity(t)
          end.compact.sum(&:default_price)
          self.price = self.subtotal
          self.quantity = 1
        end
      else
        self.subtotal = self.price.to_i * self.quantity.to_i
      end
      self.title = self.membership.name
    end

    def after_destroy
      order.calculate_total(:true)
    end

end

