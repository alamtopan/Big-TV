class Job < ActiveRecord::Base
  attr_accessible :author, :division, :position, :publish, :requirement, :unpublish 

  has_many :job_applicants

  scope :published,  -> { where('(publish IS NULL OR unpublish IS NULL) OR (publish <= NOW() AND unpublish >= NOW())').order("id DESC") }
end
