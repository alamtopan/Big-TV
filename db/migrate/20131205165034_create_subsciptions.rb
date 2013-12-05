class CreateSubsciptions < ActiveRecord::Migration
  def up
    create_table :subscriptions do |t|
      t.references :subscriber
      t.references :membership
      t.references :membership_price
      t.references :previous_membership
      t.references :previous_membership_price
      t.datetime   :activated_at
      t.datetime   :next_bill_at
      t.datetime   :billed_at
      t.datetime   :canceled_at
      t.string     :cancel_reason
      t.datetime   :deleted_at
      t.timestamps
    end

    add_index :subscriptions, :subscriber_id
    add_index :subscriptions, :membership_id
    add_index :subscriptions, :membership_price_id
  end

  def down
    drop_table :subscriptions
  end
end
