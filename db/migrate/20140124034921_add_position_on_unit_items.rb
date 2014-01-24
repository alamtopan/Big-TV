class AddPositionOnUnitItems < ActiveRecord::Migration
  def change
    add_column :unit_items, :position, :integer, default: 0
  end

end
