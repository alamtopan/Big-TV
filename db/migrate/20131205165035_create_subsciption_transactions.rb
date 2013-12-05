class CreateSubsciptionTransactions < ActiveRecord::Migration
  def up
    create_table :subscription_transactions do |t|
      t.references :subscription
      t.decimal    :amount
      t.decimal    :fee
      t.decimal    :tax
      t.decimal    :discount
      t.string     :status
      t.string     :payment_gateway
      t.text       :logs
      t.string     :request_ip_address
      t.string     :response_ip_address
      t.datetime   :deleted_at
      t.timestamps
    end

    add_index :subscription_transactions, :subscription_id
  end

  def down
    drop_table :subscription_transactions
  end
end
