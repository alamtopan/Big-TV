class Membership < ActiveRecord::Base
  attr_accessible :name, :description, :publish_on, :expire_on, :version,
                  :position, :is_published, :is_featured, :prices_attributes, 
                  :unit_item_ids, :category_id

  has_many    :prices, class_name: "MembershipPrice", dependent: :destroy
  has_many    :items, class_name: "MembershipItem", dependent: :destroy
  has_many    :unit_items, through: :items
  belongs_to  :category

  accepts_nested_attributes_for :prices, reject_if: :all_blank, allow_destroy: true

  def price_month
    self.prices.first.price if self.prices
  end

  class << self
    def package(pack)
      Membership.joins(:category).where('categories.name = ?', pack)
    end
  end
end 