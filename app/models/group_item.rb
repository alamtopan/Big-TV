class GroupItem < ActiveRecord::Base
  
  attr_accessible :name, :colour, :unit_item_ids, :position # Attributess group items
  
  has_many :unit_items # Mempunyai banyak unit items

  scope :by_position , order("position ASC") # Scope query group items
  
  before_create :before_creation

  private
    # Fungsi tambahan
    def before_creation
      last_item = GroupItem.order('position DESC').first
      if last_item
        self.position = last_item.position.to_i + 1
      else
        self.position = 1
      end
    end

    def self.batch_position(items)
      items.each do |index, item|
        unit_item = find_by_id(item[:id])
        unit_item.update_attribute(:position, item[:position]) if unit_item
      end
    end

end
