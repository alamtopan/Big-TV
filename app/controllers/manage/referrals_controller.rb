class Manage::ReferralsController < Manage::ResourcesController # Menggunakan fungsi yang ada di resource controller/induk controller
	skip_load_and_authorize_resource only: :index
	defaults :resource_class => Referral, :collection_name => 'referrals', :instance_name => 'referral'
	prepend_before_filter :draw_password, only: :update

  # Override fungsi index/crud
  def index
    @referrals = Referral.order('id ASC')
  end

  # Override fungsi action update
	def update
    @referral = Referral.find(params[:id])  
    if @referral.update_attributes(params[:referral])   
      flash[:notice] = "Successfully updated profile!" 
      redirect_to edit_manage_referral_path
    else  
      redirect_to edit_manage_referral_path
    end  
  end

  # Override halaman edit
  def edit
    if current_user.type == 'Referral'
      unless current_user.id.to_i == params[:id].to_i
        flash[:alert] = "Foorbiden!"
        redirect_to dashboard_path
      end 
    end
    @referral = Referral.find(params[:id]) 
  end

	private
    def draw_password
      %w(password password_confirmation).each do |attr|
        params[:referral].delete(attr)
      end if params[:referral] && params[:referral][:password].blank?
    end
end