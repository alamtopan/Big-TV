class CustomersController < ApplicationController
  before_filter :prepare_referal, only: [:new, :create]
  layout 'detail'

  def new
    @title_page = "Pendaftaran"
    @customer = order.orderable||Customer.new
    @membership_order = Membership.find(session[:current_premium_id]) if session[:current_premium_id]
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
      
      
      if order.save && session[:current_premium_id].present?
        redirect_to extra_path
      else
        redirect_to premium_path
      end
    else
      @customer = Customer.new(input_param)
      flash[:errors] = @customer.errors.full_messages.uniq.join(', ')
      render :new
    end
  end

  private
    def prepare_referal
      @referal = [['Hypermart', 'Hypermart'], ['Matahari', 'Matahari'], ['MTA', 'MTA'],
                ['Dealer', 'Dealer'], ['Distributor', 'Distributor'],
                ['Books and Beyond', 'Books and Beyond'],['Siloam', 'Siloam'],
                ['Koran/Billboard', 'Koran/Billboard'],
                ['Pelanggan BigTV','Pelanggan BigTV'],
                ['Others', 'Others']];
    end

end
