class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :page_content # Baca fungsi ini dahulu

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to dashboard_path, :alert => exception.message
  end

  # Error message to email
  rescue_from ActionView::Template::Error do |exception|
    #redirect_to root_path
    render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
  end

  rescue_from ActionView::MissingTemplate do |exception|
    render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
  end

  # Delete session cart
  def delete_session
    session_store = ActiveRecord::SessionStore::Session.find_by_session_id(cookies[:cart_id])
    session_store.delay(run_at: 3.hours.from_now).destroy if session_store
    cookies[:cart_id] = SecureRandom.hex(16)
  end
  

  protected
    # Variabel query untuk CMS content di halaman depan
    def page_content
      @top_content   = PageContent.where("category =?", "Slogan Bigtv").first
      @slides   = PageContent.where("category =?", "Slider Top").published.order('created_at DESC')
      @about_bigtv   = PageContent.where("category =?", "Footer About Bigtv").first
      @footer   = PageContent.where("category =?", "Footer Content").first
    end

    # Jika berhasil login sebagai user diarahkan ke halaman Dashboard
    def after_sign_in_path_for(resource)
  	  dashboard_path
	  end

    # Jika berhasil Logout kembali diarahkan ke halaman login
	  def after_sign_out_path_for(resource)
  	  new_user_session_path
	  end
    
    # Session cart
    def session_cart
      return cookies[:cart_id] if cookies[:cart_id]
      cookies[:cart_id] = request.session_options[:id]
    end

    # Order session cart
    def order
      @order ||= Order.find_or_create_by_session_id(session_cart)
    end 
end
