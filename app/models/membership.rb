class Membership < ActiveRecord::Base
  attr_accessible :name, :description, :publish_on, :expire_on, :version,
                  :position, :is_published, :is_featured

  # has_many    :memberhsip_prices
  # has_many    :memberhsip_item
  # belongs_to  :category
end