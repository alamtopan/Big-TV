class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    def after_sign_in_path_for(resource)
  	  dashboard_path
	  end

	  def after_sign_out_path_for(resource)
  	  new_user_session_path
	  end
    
    def session_cart
      return cookies[:cart_id] if cookies[:cart_id]
      cookies[:cart_id] = request.session_options[:id]
    end
    
end
