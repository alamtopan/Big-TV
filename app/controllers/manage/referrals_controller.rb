class Manage::ReferralsController < Manage::ResourcesController
	defaults :resource_class => Referral, :collection_name => 'referrals', :instance_name => 'referral'
end