class CreateUnitItems < ActiveRecord::Migration
  def up
    create_table :unit_items do |t|
      t.references  :group_item
      t.string      :name,           null: false, unique: true
      t.datetime    :deleted_at
      t.timestamps
    end
    add_attachment  :unit_items, :logo
    add_index       :unit_items, :name
  end

  def down
    remove_attachment :unit_items, :logo
    drop_table :unit_items
  end
end
