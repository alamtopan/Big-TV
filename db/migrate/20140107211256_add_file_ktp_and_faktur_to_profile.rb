class AddFileKtpAndFakturToProfile < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.has_attached_file :file_ktp
      t.has_attached_file :file_faktur
    end
  end

  def self.down
    drop_attached_file :profiles, :file_ktp
    drop_attached_file :profiles, :file_faktur
  end
end

