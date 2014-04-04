class CreateRegPromos < ActiveRecord::Migration
  def change
    create_table :reg_promos do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :subject

      t.timestamps
    end
  end
end
