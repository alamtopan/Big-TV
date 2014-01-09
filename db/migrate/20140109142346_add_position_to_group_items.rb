class AddPositionToGroupItems < ActiveRecord::Migration
  def change
    add_column :group_items, :position, :integer
  end
end
