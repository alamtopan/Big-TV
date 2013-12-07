class Membership < ActiveRecord::Base
  attr_accessible :name, :description, :publish_on, :expire_on, :version,
                  :position, :is_published, :is_featured

  has_many    :memberhsip_prices, dependent: :destroy
  # has_many    :memberhsip_item
  # belongs_to  :category

  accepts_nested_attributes_for :memberhsip_prices, reject_if: :all_blank, allow_destroy: true
end