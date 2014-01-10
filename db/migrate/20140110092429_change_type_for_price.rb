class ChangeTypeForPrice < ActiveRecord::Migration
  def up
    change_column :orders, :total, :decimal
    add_column :payments, :total, :decimal
    change_column :order_items, :price, :decimal
    change_column :order_items, :subtotal, :decimal
  end

  def down
    change_column :orders, :total, :integer
    change_column :order_items, :price, :integer
    change_column :order_items, :subtotal, :integer
  end
end
