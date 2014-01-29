class Manage::ReferralsController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
	defaults :resource_class => Referral, :collection_name => 'referrals', :instance_name => 'referral'
	prepend_before_filter :draw_password, only: :update

	private
    def draw_password
      %w(password password_confirmation).each do |attr|
        params[:referral].delete(attr)
      end if params[:referral] && params[:referral][:password].blank?
    end
end