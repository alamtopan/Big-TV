class AddStatusHdToUnitItems < ActiveRecord::Migration
  def change
    add_column :unit_items, :status_hd, :boolean, default: false
  end
end
