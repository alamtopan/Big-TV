class CreateRegional < ActiveRecord::Migration
  def up
    create_table :regionals do |t|
      t.string :name
      t.timestamp
    end
  end

  def down
    drop_table :regionals
  end
end
