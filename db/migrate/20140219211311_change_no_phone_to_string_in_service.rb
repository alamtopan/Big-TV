class ChangeNoPhoneToStringInService < ActiveRecord::Migration
  def up
		change_column :services, :phone, :string
	end

	def down
		change_column :services, :phone, :integer
	end
end
