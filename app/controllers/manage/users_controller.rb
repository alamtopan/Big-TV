class Manage::UsersController < Manage::ResourcesController
  skip_load_and_authorize_resource only: :index
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  prepend_before_filter :draw_password, only: :update
  
  def sign_out
    redirect_to root_path
  end

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
        params[:user].delete(attr)
      end if params[:user] && params[:user][:password].blank?
    end
end
