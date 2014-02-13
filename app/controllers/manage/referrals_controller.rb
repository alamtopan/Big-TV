class Manage::ReferralsController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
	defaults :resource_class => Referral, :collection_name => 'referrals', :instance_name => 'referral'
	prepend_before_filter :draw_password, only: :update

	def update
    @user = User.find(params[:id])  
    if @user.update_attributes(params[:user])   
      flash[:notice] = "Successfully updated profile!" 
      redirect_to edit_manage_user_path
    else  
      redirect_to edit_manage_user_path
    end  
  end

  def edit
    if current_user.type == 'Referral'
      unless current_user.id.to_i == params[:id].to_i
        flash[:alert] = "Foorbiden!"
        redirect_to dashboard_path
      end 
    end
    @user = User.find(params[:id]) 
  end

	private
    def draw_password
      %w(password password_confirmation).each do |attr|
        params[:referral].delete(attr)
      end if params[:referral] && params[:referral][:password].blank?
    end
end