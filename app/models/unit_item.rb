class UnitItem < ActiveRecord::Base
  # Attributess dari model unit items  
  attr_accessible :group_item_id, :name, :logo,:status_hd, :free, :position
  has_attached_file :logo, styles:  { 
                                      :medium => "300x300>", 
                                      :thumb => "100x100>" 
                                    }, 
                                    :default_url => "/assets/no-image.png" # Role field logo

  acts_as_list scope: :group_item

  # Scope query
  scope :by_position, order('position ASC')
  scope :by_hd, where('status_hd = TRUE')
  scope :by_not_hd, where('status_hd = FALSE')

  validates_presence_of   :name # Validation present
  validates_uniqueness_of :name # Validation unique

  belongs_to :group_item
  has_many   :membership_items # Mempunyai banyak membership items
  has_many   :memberships, through: :membership_items # Mempunyai banyak membership

  def self.free_channels
    where('free = ?', true).by_position
  end

  def self.batch_position(items)
    items.each do |index, item|
      unit_item = find_by_id(item[:id])
      unit_item.update_attribute(:position, item[:position]) if unit_item
    end
  end

end
