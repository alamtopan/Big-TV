class AddColumnFreeToUnitItems < ActiveRecord::Migration
  def change
    add_column :unit_items, :free, :boolean, default: false
  end
end
