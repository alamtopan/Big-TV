class MembershipItem < ActiveRecord::Base
  
  attr_accessible :membership_id, :unit_item_id # Attributess membership items
  
  validates_uniqueness_of :unit_item_id, on: :membership_id # Validations unique

  belongs_to :unit_item
  belongs_to :membership

end
