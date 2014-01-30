class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :page_content

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to dashboard_path, :alert => exception.message
  end
  

  protected
    def page_content
      @footer   = PageContent.where("category =?", "Footer Content").first
    end

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

    def order
      @order ||= Order.find_or_create_by_session_id(session_cart)
    end
    
end
