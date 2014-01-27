class ChangeTanggallahirToDateInProfiles < ActiveRecord::Migration
  def up
		change_column :profiles, :tanggal_lahir, :date
	end

	def down
		change_column :profiles, :tanggal_lahir, :string
	end
end
