class CreateMembershipItems < ActiveRecord::Migration
  def up
    create_table :membership_items do |t|
      t.references  :unit_item
      t.references  :membership
      t.datetime    :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :membership_items
  end
end
