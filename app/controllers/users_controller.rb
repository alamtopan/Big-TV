class UsersController < InheritedResources::Base
  before_filter :auth, only: :update

  def index
    @users = User.where("id != ?", current_user.id).order("id DESC") 
  end

  def auth
    if params[:user] && params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end
  end
end