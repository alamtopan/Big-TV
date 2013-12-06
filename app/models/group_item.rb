class GroupItem < ActiveRecord::Base
  
  attr_accessible :name, :colour, :unit_item_ids

  validates_presence_of   :name
  validates_uniqueness_of :name
  
  has_many :unit_items

end
