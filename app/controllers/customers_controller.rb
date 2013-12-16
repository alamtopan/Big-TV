class CustomersController < ApplicationController
  layout 'detail'
  
  def new
    @customer = Customer.new  
  end

  def create
    customer = Customer.find_or_initialize_by_email(params[:customer][:email])
    if customer.update_attributes(params[:customer])
      sign_in(:customer, customer)
      if session[:current_premium_id].present?
        redirect_to extra_path
      else 
        redirect_to root_path
      end
    else
      flash[:errors] = customer.errors.full_messages.uniq.join(', ')
      redirect_to new_customer
    end
  end

end