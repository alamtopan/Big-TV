class Manage::ReferralCategoriesController < Manage::ResourcesController # Menggunakan fungsi yang ada di resource controller/induk controller
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => ReferralCategory, :collection_name => 'referral_categories', :instance_name => 'referral_category'
end