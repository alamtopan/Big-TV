class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :no_phone
      t.string :no_hp
      t.text :address
      t.string :city
      t.string :province
      t.string :codepos

      t.timestamps
    end
  end
end
