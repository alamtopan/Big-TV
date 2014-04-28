class AddSummaryInMemberships < ActiveRecord::Migration
	def change
		add_column :memberships, :summary, :string
	end
end
