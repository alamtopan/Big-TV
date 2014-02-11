class AddReferralInfoInProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :referral_info, :string
  end
end
