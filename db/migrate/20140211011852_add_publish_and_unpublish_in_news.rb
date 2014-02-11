class AddPublishAndUnpublishInNews < ActiveRecord::Migration
	def change
		add_column :blogs, :publish, :date
		add_column :blogs, :unpublish, :date
	end
end
