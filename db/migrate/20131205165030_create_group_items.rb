class CreateGroupItems < ActiveRecord::Migration
  def up
    create_table :group_items do |t|
      t.string      :name,         null: false, unique: true
      t.string      :colour
      t.datetime    :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :unit_items
  end
end
