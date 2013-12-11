class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :total
      t.string  :session_id
      t.string  :code_prefix
      t.integer :position
      t.string  :code
      t.integer :orderable_id
      t.string  :orderable_type
      t.string  :status
      t.integer :period
      t.string  :period_name
      t.timestamps
    end
  end
end
