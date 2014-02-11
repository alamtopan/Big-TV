class Blog < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :author, :description, :picture, :title, :publish, :unpublish
  friendly_id :title, use: [:slugged]

  has_attached_file :picture, styles:  { 
                                         :large  => "800x800>",
                                         :medium => "300x300>", 
                                         :thumb  => "100x100>" 
                                        }, 
                                        :default_url => "/assets/no-image.png"
  validates_presence_of :title

  scope :published,  -> { where('(publish IS NULL OR unpublish IS NULL) OR (publish <= NOW() AND unpublish >= NOW())') }

end
