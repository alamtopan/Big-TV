class AddReferralCategoryIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :referral_category_id, :integer, default: 0
  end
end
