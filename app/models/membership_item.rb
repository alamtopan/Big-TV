class MembershipItem < ActiveRecord::Base
  
  attr_accessible :membership_id, :unit_item_id
  
  validates_uniqueness_of :unit_item_id, on: :membership_id

  belongs_to :unit_item
  belongs_to :membership

end
