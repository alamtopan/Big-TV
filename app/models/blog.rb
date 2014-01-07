class Blog < ActiveRecord::Base
  attr_accessible :author, :description, :picture, :title

  has_attached_file :picture, styles:  { 
                                     :medium => "300x300>", 
                                     :thumb => "100x100>" 
                                    }, 
                                    :default_url => "/assets/no-image.png"
  validates_presence_of :title
end
