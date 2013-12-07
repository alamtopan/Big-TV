class UsersController < ResourcesController
  prepend_before_filter :draw_password, only: :update

  private
    def draw_password
      %w(password password_confirmation).each do |attr|
        params[:user].delete(attr)
      end if params[:user] && params[:user][:password].blank?
    end
end
