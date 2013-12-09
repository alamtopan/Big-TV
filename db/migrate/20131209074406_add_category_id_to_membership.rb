class AddCategoryIdToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :category_id, :integer
  end
end
