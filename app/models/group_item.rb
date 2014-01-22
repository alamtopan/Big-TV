class GroupItem < ActiveRecord::Base
  
  attr_accessible :name, :colour, :unit_item_ids, :position
  
  has_many :unit_items

  scope :by_position , order("position ASC")
  
  before_create :before_creation

  private
    def before_creation
      last_item = GroupItem.order('position DESC').first
      if last_item
        self.position = last_item.position.to_i + 1
      else
        self.position = 1
      end
    end

end
