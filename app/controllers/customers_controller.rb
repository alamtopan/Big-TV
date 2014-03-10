class CustomersController < ApplicationController
  layout 'detail' # Render template detail

  # Fungsi di halaman registrasi customer
  def new
    cookies[:cart_id] = SecureRandom.hex(16)
    @title_page = "Pendaftaran"
    @customer = order.orderable||Customer.new

    prepare_customer_form
  end

  # Fungsi create action registrasi customer
  def create
    input_param = params[:user] || params[:customer]
    if input_param
      input_param.delete(:password)
      input_param.delete(:password_confirmation)
      input_param.delete(:username)
      if input_param[:profile_attributes].present? && input_param[:referral_category_id].present?
        referral_category = ReferralCategory.find_by_id(input_param[:referral_category_id])
        input_param[:profile_attributes][:referal] = referral_category.name if referral_category
      end
    end

    @customer = Customer.find_or_initialize_by_email(input_param[:email])
    prepare_price

    if verify_recaptcha(model: @customer, message: "Verification code is invalid") && @customer.update_attributes(input_param)
      order.orderable = @customer
      # CustomerMailer.delay.welcome_email(@customer)
      CustomerMailer.delay.welcome_email_admin(@customer)
      
      if order.save && session[:current_premium_id].present?
        redirect_to extra_path
      else
        redirect_to premium_path
      end
    else
      @customer = Customer.new(input_param)
      flash[:errors] = @customer.errors.full_messages.uniq.join(', ')
      prepare_customer_form
      render :new
    end
  end

  private
    # Fungsi tambahan reistrasi customer
    def prepare_customer_form
      if current_user && @customer.profile
        @customer.profile.referal_id = current_user.code 
        @customer.profile.referal = current_user.referral_category.name if current_user.referral_category
      end
      @referral = ReferralCategory.order("id ASC")
      prepare_price
    end

    def prepare_price

      @membership_price = MembershipPrice.find(session[:current_price_id]) if session[:current_price_id]
      
      if session[:current_premium_id]
        @membership_order = Membership.find(session[:current_premium_id])    
        @membership_price = @membership_order.prices.first if @membership_order && !@membership_price
      end
    end
end
