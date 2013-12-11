class UnitItem < ActiveRecord::Base
  
  attr_accessible :group_item_id, :name, :logo,:status_hd
  has_attached_file :logo, styles:  { 
                                      :medium => "300x300>", 
                                      :thumb => "100x100>" 
                                    }, 
                                    :default_url => "/assets/no-image.png"

  validates_presence_of   :name
  validates_uniqueness_of :name

  belongs_to :group_item
  has_many   :membership_items
  has_many   :memberships, through: :membership_items

end
