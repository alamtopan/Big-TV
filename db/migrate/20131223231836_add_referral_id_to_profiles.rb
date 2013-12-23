class AddReferralIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :referal_id, :string
  end
end
