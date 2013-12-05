class CreateMembershipPrices < ActiveRecord::Migration
  def up
     create_table :membership_prices do |t|
      t.references :membership
      t.decimal    :price,        default: 0
      t.integer    :total_period, default: 0
      t.string     :periode_name, null: false, default: 'day'
      t.boolean    :free,         default: false
      t.datetime   :deleted_at
      t.timestamps
    end

    add_index :membership_prices, :membership_id
  end

  def down
    drop_table :membership_prices
  end
end
