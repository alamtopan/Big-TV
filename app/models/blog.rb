class Blog < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :author, :description, :picture, :title, :publish, :unpublish , :with_register# Attributess blog/promo
  friendly_id :title, use: [:slugged]

  has_attached_file :picture, styles:  { 
                                         :large  => "800x800>",
                                         :medium => "300x300>", 
                                         :thumb  => "100x100>" 
                                        }, 
                                        :default_url => "/assets/no-image.png" # Role untuk field picture
  validates_presence_of :title

  # Scope query untuk show data
  scope :published,  -> { where('(publish IS NULL OR unpublish IS NULL) OR (publish <= NOW() AND unpublish >= NOW())').order("id DESC") }

end
