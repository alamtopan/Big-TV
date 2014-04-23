class AddWithRegistrationInNews < ActiveRecord::Migration
	def change
		add_column :blogs, :with_register, :boolean
	end
end
