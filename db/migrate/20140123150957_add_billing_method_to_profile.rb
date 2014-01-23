class AddBillingMethodToProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :billing_method, :string
  end
end
