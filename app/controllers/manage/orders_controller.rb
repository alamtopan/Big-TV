class Manage::OrdersController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Order, :collection_name => 'orders', :instance_name => 'order'

  def new
  	@memberships   = Membership.packages_by_category('premium')
    @groups        = GroupItem.includes(unit_items: [:memberships]).by_position

    @customer = order.orderable||Customer.new
    prepare_customer_form
  end

  def customer_form
  	@customer = order.orderable||Customer.new
  	prepare_customer_form
  end

  def create_customer_form
    input_param = params[:user] || params[:customer]
    if input_param
      input_param.delete(:password)
      input_param.delete(:password_confirmation)
      input_param.delete(:username)
    end

    @customer = Customer.find_or_initialize_by_email(input_param[:email])
    @membership_order = Membership.find(session[:current_premium_id]) if session[:current_premium_id]

    if @customer.update_attributes(input_param)
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