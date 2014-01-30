class CreateReferralCategories < ActiveRecord::Migration
  def change
    create_table :referral_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
