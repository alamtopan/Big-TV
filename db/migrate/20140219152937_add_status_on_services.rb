class AddStatusOnServices < ActiveRecord::Migration
  def change
  	add_column :services, :status, :string
  end
end
