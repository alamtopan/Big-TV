class AddPublishAndUnpublishInPageContent < ActiveRecord::Migration
  def change
		add_column :page_contents, :publish, :date
		add_column :page_contents, :unpublish, :date
	end
end
