class PageContent < ActiveRecord::Base
  attr_accessible :category, :description, :title, :picture, :link, :publish, :unpublish # Attributess dari model page content
  has_attached_file :picture, styles:  { 
                                     :medium => "300x300>", 
                                     :thumb => "100x100>" 
                                    }, 
                                    :default_url => "/assets/no-image.png" # Role field picture

  validates_presence_of :title # Validation

  # Scope query
  scope :published,  -> { where('(publish IS NULL OR unpublish IS NULL) OR (publish <= NOW() AND unpublish >= NOW())') }

end
