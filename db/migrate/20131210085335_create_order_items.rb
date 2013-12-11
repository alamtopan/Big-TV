class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :membership_id
      t.string  :title
      t.integer :order_id
      t.integer :quantity
      t.integer :price
      t.integer :subtotal
      t.timestamps
    end
  end
end
