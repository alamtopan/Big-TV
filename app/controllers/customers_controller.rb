class CustomersController < ApplicationController
  before_filter :prepare_referal, only: [:new, :create]
  layout 'detail'

  def new
    @customer = Customer.new
    @membership_order = Membership.find(session[:current_premium_id]) if session[:current_premium_id]
  end

  def create
    @customer = Customer.find_or_initialize_by_email(params[:customer])
    @membership_order = Membership.find(session[:current_premium_id]) if session[:current_premium_id]

    if verify_recaptcha(model: @customer, message: "Verification code is invalid") && @customer.update_attributes(params[:customer])
      sign_in(:customer, @customer)
      if session[:current_premium_id].present?
        redirect_to extra_path
      else
        redirect_to premium_path
      end
    else
      flash[:errors] = @customer.errors.full_messages.uniq.join(', ')
      render :new
    end
  end

  private
    def prepare_referal
      @referal = [['Hypermart', 'Hypermart'], ['Matahari', 'Matahari'], ['MTA', 'MTA'],
                ['Dealer', 'Dealer'], ['Distributor', 'Distributor'],
                ['Books and Beyond', 'Books and Beyond'],['Siloam', 'Siloam'],
                ['Koran/Billboard', 'Koran/Billboard'],['Others', 'Others'],
                ['Pelanggan BigTV','Pelanggan BigTV'] ];
    end

end
