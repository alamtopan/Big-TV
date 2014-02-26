class JobApplicant < ActiveRecord::Base
  attr_accessible :email, :name, :position, :resume, :status, :file_resume
  has_attached_file :file_resume

  belongs_to :job, foreign_key: "position"

end
