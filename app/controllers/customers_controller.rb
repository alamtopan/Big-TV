class CustomersController < ApplicationController
  layout 'detail'

  def new
    @title_page = "Pendaftaran"
    @customer = order.orderable||Customer.new

    prepare_customer_form
  end

  def create
    input_param = params[:user] || params[:customer]
    if input_param
      input_param.delete(:password)
      input_param.delete(:password_confirmation)
      input_param.delete(:username)
    end

    @customer = Customer.find_or_initialize_by_email(input_param[:email])
    @membership_order = Membership.find(session[:current_premium_id]) if session[:current_premium_id]

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
    def prepare_customer_form
      if current_user && @customer.profile
        @customer.profile.referal_id = current_user.code 
        @customer.profile.referal = current_user.referral_category.name if current_user.referral_category
      end

      @membership_order = Membership.find(session[:current_premium_id]) if session[:current_premium_id]
      @referral = ReferralCategory.order("id ASC")
    end
end
