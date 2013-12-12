class AddAttributesToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :jenis_kelamin, :string
    add_column :profiles, :tanggal_lahir, :date
    add_column :profiles, :email, :string
    add_column :profiles, :referal, :string
    add_column :profiles, :tipe_identitas, :string
    add_column :profiles, :no_identitas, :string
  end
end
