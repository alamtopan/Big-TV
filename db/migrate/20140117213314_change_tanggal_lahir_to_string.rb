class ChangeTanggalLahirToString < ActiveRecord::Migration
  def up
		change_column :profiles, :tanggal_lahir, :string
	end

	def down
		change_column :profiles, :tanggal_lahir, :date
	end
end
