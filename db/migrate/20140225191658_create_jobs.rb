class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :position
      t.text :requirement
      t.string :division
      t.date :publish
      t.date :unpublish
      t.string :author

      t.timestamps
    end
  end
end
