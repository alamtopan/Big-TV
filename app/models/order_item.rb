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

  class << self
    Category::Config::NAMES.each do |name_item|
      define_method("#{ name_item.downcase.pluralize }") do
         category = Category.find_by_name("#{name_item.downcase}")
         return [] unless category
         includes(:membership).where(['memberships.category_id = ?', category.id])
      end
      
      define_method("#{ name_item.downcase.singularize }") do
        send("#{ name_item.downcase.pluralize }").first
      end
    end
  end


  def membership_category
    @membership_category ||= self.membership.category.name.to_s
  end

  Category::Config::NAMES.each do |val|
    define_method("#{ val.downcase }?") do
      return false unless self.membership
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
          price_per_month = (1..requested_decoder).map do |t|
            Membership.decoder_by_quantity(t)
          end.compact.sum(&:default_price)
          self.price = price_per_month
          self.quantity = 1 if self.quantity.to_i < 1
        end
      end
      
      self.subtotal = self.price.to_i * self.quantity.to_i
      self.title = self.membership.name if self.membership.present?
    end

    def after_destroy
      order.calculate_total(:true)
    end

end

