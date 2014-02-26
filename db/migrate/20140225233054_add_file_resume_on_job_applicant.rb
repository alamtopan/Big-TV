class AddFileResumeOnJobApplicant < ActiveRecord::Migration
  def self.up
    change_table :job_applicants do |t|
      t.has_attached_file :file_resume
    end
  end

  def self.down
    drop_attached_file :job_applicants, :file_resume
  end
end
