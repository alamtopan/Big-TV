class CreateJobApplicants < ActiveRecord::Migration
  def change
    create_table :job_applicants do |t|
      t.string :name
      t.string :position
      t.string :email
      t.text :resume
      t.string :status

      t.timestamps
    end
  end
end
