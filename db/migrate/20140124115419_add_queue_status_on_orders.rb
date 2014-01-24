class AddQueueStatusOnOrders < ActiveRecord::Migration
  def change
    add_column :orders, :is_queue, :boolean, default: false
  end
end
