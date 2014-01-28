class AddPictureInPageContent < ActiveRecord::Migration
  def self.up
    change_table :page_contents do |t|
      t.has_attached_file :picture
    end
  end

  def self.down
    drop_attached_file :page_contents, :picture
  end
end
