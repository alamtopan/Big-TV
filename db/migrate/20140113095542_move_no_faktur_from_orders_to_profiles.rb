class MoveNoFakturFromOrdersToProfiles < ActiveRecord::Migration
  def up
    drop_attached_file :orders, :file_faktur
    change_table :profiles do |t|
      t.has_attached_file :file_faktur
    end
  end

  def down
    drop_attached_file :profiles, :file_faktur
    change_table :orders do |t|
      t.has_attached_file :file_faktur
    end
  end
end
