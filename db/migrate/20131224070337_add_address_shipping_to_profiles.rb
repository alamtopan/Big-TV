class AddAddressShippingToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :address_shipping, :text
  end
end
