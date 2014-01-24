class Membership < ActiveRecord::Base
  attr_accessible :name, :description, :publish_on, :expire_on, :version,
                  :position, :is_published, :is_featured, :prices_attributes,
                  :unit_item_ids, :category_id

  has_many    :prices, class_name: "MembershipPrice", dependent: :destroy
  has_many    :items, class_name: "MembershipItem", dependent: :destroy
  has_many    :unit_items, through: :items
  belongs_to  :category

  accepts_nested_attributes_for :prices, reject_if: :all_blank, allow_destroy: true

  scope :by_position, order("memberships.position ASC")

  acts_as_list

  Category::Config::NAMES.each do |val|
    define_method("#{ val.downcase }?") do
      category.name =~ /#{val}/i
    end
  end

  def self.extra_by_order(order)
    includes(:unit_items, :category).
      where('categories.name = ?', 'extra').
      where('unit_items.id NOT IN (?)', order.premium_unit_items.map(&:id))
  end

  def category_name
    return '' unless category
    category.name
  end

  def requires_upgrade_by_decoder?(original_items)
    single_decoder = Membership.decoder_by_quantity(1)
    !original_items.find_by_membership_id(single_decoder.id) && name !~ /universe|star/i
  end

  def price_month
    self.prices.first.price if self.prices
  end

  class << self
    def packages_by_category(_package)
      includes(:category, :prices, :unit_items).where(['categories.name = ?', _package]).by_position
    end

    def other_packages
      joins(:category).where('categories.name LIKE ?','%other%')
    end

    def decoder_by_quantity(qty)
      where('name LIKE ?',"#{qty} %").first
    end
  end

  def default_price
    pricing = prices.where({periode_name: 'month', total_period: 1}).first
    return pricing.price if pricing
    0
  end


end
