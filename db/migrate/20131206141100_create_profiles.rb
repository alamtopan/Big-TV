class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :no_phone
      t.integer :no_hp
      t.text :address
      t.string :city
      t.string :province
      t.string :codepos

      t.timestamps
    end
  end
end
