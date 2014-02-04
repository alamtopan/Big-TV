class Blog < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :author, :description, :picture, :title
  friendly_id :title, use: [:slugged]

  has_attached_file :picture, styles:  { 
                                     :medium => "300x300>", 
                                     :thumb => "100x100>" 
                                    }, 
                                    :default_url => "/assets/no-image.png"
  validates_presence_of :title

end
