class AddLinkInPageContent < ActiveRecord::Migration
  def change
  	add_column :page_contents, :link, :string
  end
end
