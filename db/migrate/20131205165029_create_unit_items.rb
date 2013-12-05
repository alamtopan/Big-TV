class CreateUnitItems < ActiveRecord::Migration
  def up
    create_table :unit_items do |t|
      t.references  :group_item
      t.string      :name,           null: false, unique: true
      t.string      :item_key,       null: false, unique: true
      t.string      :unit_name
      t.text        :description
      t.boolean     :unlimited,      default: false
      t.decimal     :quantity_limit, default: 0
      t.datetime    :deleted_at
      t.timestamps
    end
    add_attachment  :unit_items, :logo
    add_index       :unit_items, ["item_key", "unit_name"]
  end

  def down
    drop_table :unit_items
    remove_attachment :unit_items, :logo
  end
end
