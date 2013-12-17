class CreateOffices < ActiveRecord::Migration
  def up
    create_table :offices do |t|
      t.references  :category_office
      t.references  :regional
      t.string      :name
      t.string      :address
      t.string      :phone_area
      t.text        :no_phone
      t.text        :no_fax
      t.string      :longitude
      t.string      :latitude
      t.timestamp
    end
  end

  def down
    drop_table :offices
  end
end
