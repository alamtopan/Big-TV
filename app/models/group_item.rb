class GroupItem < ActiveRecord::Base
  
  attr_accessible :name, :colour, :unit_item_ids

  has_many :unit_items

end
