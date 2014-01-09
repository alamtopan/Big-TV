class GroupItem < ActiveRecord::Base
  
  attr_accessible :name, :colour, :unit_item_ids, :position

  validates_presence_of   :name, :position
  validates_uniqueness_of :name, :position
  
  has_many :unit_items

end
