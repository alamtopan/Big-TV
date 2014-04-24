class JobApplicant < ActiveRecord::Base
  attr_accessible :email, :name, :position, :resume, :status, :file_resume
  has_attached_file :file_resume

  belongs_to :job, foreign_key: "position"

  validates :name, :position, :email
  validates_attachment :file_resume, size: {less_than: 2.megabytes}
  validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i

end
