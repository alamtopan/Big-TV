class Manage::OrdersController < Manage::ResourcesController # Menggunakan fungsi yang ada di resource controller juga
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Order, :collection_name => 'orders', :instance_name => 'order'

  # Override fungsi dihalaman index/crud
  def index
    @orders = current_user.type == 'Referral' ? current_user.orders : Order
    @orders = @orders.success_order.order('orders.created_at ASC')
  end

  # Override fungsi dihalaman show data
  def show
    @order_view = Order.find(params[:id])
  end

  # Override fungsi dihalaman edit
  def edit
    @order_view = Order.find(params[:id])
  end

  def new
  	@memberships   = Membership.packages_by_category('premium')
    @groups        = GroupItem.includes(unit_items: [:memberships]).by_position

    @customer = order.orderable||Customer.new
    prepare_customer_form
  end

  # Fungsi untuk halaman create subcribe baru
  def new_customer
    delete_session
  	@customer = order.orderable||Customer.new
  	prepare_customer_form
  end

  # Fungsi untuk action create customer baru
  def create_customer
    input_param = params[:user] || params[:customer]
    if input_param
      input_param.delete(:password)
      input_param.delete(:password_confirmation)
      input_param.delete(:username)
      if current_user.is_a?(Referral) && input_param[:profile_attributes].present?
        input_param[:referral_category_id] = current_user.referral_category_id
        input_param[:profile_attributes][:referal_id] = current_user.code
        input_param[:profile_attributes][:referal] = current_user.referral_category.name if current_user.referral_category
      end
    end

    @customer = Customer.find_or_initialize_by_email(input_param[:email])
    @membership_order = Membership.find(session[:current_premium_id]) if session[:current_premium_id]
    
    if @customer.update_attributes(input_param)
      order.orderable = @customer
      # CustomerMailer.delay.welcome_email(@customer)
      CustomerMailer.delay.welcome_email_admin(@customer)
      
      if order.save && session[:current_premium_id].present?
        redirect_to extra_manage_orders_path
      else
        redirect_to premium_manage_orders_path
      end
    else
      @customer = Customer.new(input_param)
      flash[:errors] = @customer.errors.full_messages.uniq.join(', ')
      prepare_customer_form
      render :new
    end
  end

  # Fungsi untuk halaman pilih extra paket
  def extra
    display_extra_data = false

    if request.xhr? && params[:extra_id].present?
      order_item = order.items.find_by_membership_id(params[:extra_id])

      if params[:add].to_s == 'true' && !order_item
        extra_package = Membership.find_by_id(params[:extra_id])
        order.add_item(extra_package,session_cart,session[:current_price_id]) if extra_package
      elsif order_item
        order_item.destroy
      end

    elsif params[:membership_id].present? || session[:current_premium_id]
      current_premium_id = params[:membership_id].present? ? params[:membership_id] : session[:current_premium_id]
      current_price_id = params[:price_id].present? ? params[:price_id] : session[:current_price_id]
      session[:current_price_id] = current_price_id if current_price_id.present?
      item = Membership.find_by_id(current_premium_id)
      order.add_item(item, session_cart, current_price_id)
      display_extra_data = true

    elsif order.items.premium.present?
      display_extra_data = true

    else
      flash[:alert] = 'Mohon pilih salah satu paket premium!'
      redirect_to premium_manage_orders_path # Redirect ke halaman premium paket dihalaman backend/spg
    end
    
    if display_extra_data
      premium_item = order.items.premium
      if premium_item 
      #   if premium_item.title !~ /universe/i
          @memberships = Membership.includes(:unit_items,:category).
                          where('id IN (?)', Membership.extra_by_order(order).map(&:id)).
                          by_position
          # remove all cart items which are not in extra package
          order.items.extras.
            where('membership_id NOT IN (?)', @memberships.map(&:id)).
            destroy_all if @memberships.present?
        # else
        #   order.items.extras.destroy_all
        # end
      end

      unless @memberships
        redirect_to rental_box_manage_orders_path # Redirect ke halaman pilih dekoder dihalaman backend/spg
      end
    end   
  end

  # Fungsi yang digunakan dihalaman premium paket
  def premium
    if request.referer.to_s =~ /customer/i && order.items.present?
      redirect_to extra_manage_orders_path
    else
      @memberships = Membership.packages_by_category('premium')
      @groups = GroupItem.includes(unit_items: [:memberships]).all
    end
  end

  # Fungsi yang digunakan dihalaman preview data customer
  def preview
    @referral = ReferralCategory.order("id ASC")
    @title_page = "More Info"
    if order.items.select{|i| i.premium? }.blank?
      redirect_to premium_manage_orders_path
    elsif order.total.to_i < 1
      redirect_to dashboard_path
    end

    if current_user && order
      customer_profile = order.orderable ? order.orderable.profile : nil
      if customer_profile
        customer_profile.referal_id = current_user.code 
        customer_profile.referal = current_user.referral_category.name if current_user.referral_category
      else
        redirect_to new_customer_manage_orders_path
      end
    end
  end

  # Fungsi yang digunakan dihalaman dekoder
  def rental_box
    @title_page = "Sewa Dekoder"
    @memberships = Membership.packages_by_category('other')
    @upgrades = Membership.where('name LIKE ? OR name LIKE ?', '%universe%', '%star%')

    @order  = order
    if order.items.where('membership_id IN (?)', @memberships.map(&:id)).blank?
      single_decoder = @memberships.where('memberships.name LIKE ?','1 %').first
      order.add_item(single_decoder, session_cart,session[:current_price_id])
    end
  end

  # Fungsi tambahan yang digunakan untuk subcribe
  def subcribe
    customer_info = params[:user] || params[:customer]
    if customer_info.blank?
      flash[:errors] = "Silahkan isi aplikasi pendaftaran dengan benar"
      if request.xhr?
        render json: {error: 'Invalid Parameters', redirect_url: preview_path}, status: :unprocessable_entity
      else
        redirect_to preview_manage_orders_path
      end
    elsif order.orderable.blank?
      flash[:errors] = "Silahkan isi data pelanggan terlebih dahulu"
      if request.xhr?
        render json: {error: 'Invalid Customer', redirect_url: new_customer_manage_orders_path}, status: :unprocessable_entity
      else
        redirect_to new_customer_manage_orders_path
      end
    else
      #user = Customer.find_or_initialize_by_email(params[:user][:email])
      customer_info.delete(:password)
      customer_info.delete(:password_confirmation)
      customer_info.delete(:username)
      @customer = order.orderable
      
      if @customer.update_attributes(customer_info) && save_order
        order.items.where('membership_id IS NULL').destroy_all

        # if customer_info[:profile_attributes][:billing_method].to_s =~ /post/i
        #   item = order.items.find_or_initialize_by_membership_id(nil)
        #   item.title = 'Biaya Pengiriman'
        #   item.price = 7500
        #   item.quantity = 1
        #   item.save
        #   order.calculate_total(:conditional)
        # end

        flash[:success] = 'success'
        # CustomerMailer.delay.thanks_email(order)
        # CustomerMailer.delay.email_order_to_admin(order)

        response = BigSoap::Client.new.create_customer(@customer)
        if response && response['CUSTOMERNO'].present?
          @customer.update_column(:code, response['CUSTOMERNO'])
          order.update_column(:code, response['CUSTOMERNO'])
        end
        
        @words = Digest::SHA1.hexdigest("#{"%.2f" % order.grand_total}#{ENV['MALL_ID']}#{ENV['SHARED_KEY']}#{order.code}")
        @payment_method = params[:payment_method]
        delete_session
        unless request.xhr?
          redirect_to thanks_path(token: order.token)
        end
      else
        flash[:errors] = @customer.errors.full_messages
        unless request.xhr?
          redirect_to preview_manage_orders_path
        end
      end
    end
  end

  private
    # dibawah ini beberapan Fungsi tambahan yang digunakan untuk subcriptions
    
    def prepare_customer_form
      prepopulate_customer_info
      @membership_order = Membership.find(session[:current_premium_id]) if session[:current_premium_id]
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

    def prepopulate_customer_info
      if current_user && @customer.new_record? && @customer.profile
        @customer.profile.referal_id = current_user.code 
        @customer.profile.referal = current_user.referral_category.name if current_user.referral_category
        @customer.referral_category_id = current_user.referral_category_id
      end
    end

    def prepare_order_by_token
      if params[:token].present? && @order = Order.find_by_token(params[:token])
        @customer         = @order.orderable
        @customer_profile = @customer.profile
        render layout: 'detail'
      else
        redirect_to dashboard_path
      end
    end

    def product
      @product ||= Membership.find(params[:id])
    end

    def save_order
      period = params[:order][:period].to_i if params[:order]
      order.session_id = nil
      if period.to_i > 0
        order.period = period
        order.period_name = 'month'
      end
      order.payment_method = params[:payment_method]
      order.file_faktur = params[:file_faktur] if params[:file_faktur].present?
      order.save
    end

    def check_order(order,params_membership)
        order.items.each do |item|
        if params_membership.kind_of?(Array) && !params_membership.include?(item.membership_id)
          item.destroy
        elsif params_membership == item.membership_id
          item.destroy
        end
      end
    end

    def check_decoder_membership(params_membership)
      selected_decoder = Membership.find(params_membership)
      minimum_package = Membership.where("name LIKE ?", "%Star%").first
      order.items.each do |item|
        if item.premium?
          if item.subtotal < minimum_package.price_month && selected_decoder.price_month > 50000
            flash[:alert] = "Your Premium Package Must Be least Big Star Package,
                             Do You want To Get Big Star Package?
                             <a href='#{update_package_path}' >yes</a> |
                             <a href='#' data-dismiss='alert'>no</a>".html_safe
            flash[:upgrade_channel] = true
            return false
          end
        end
      end
      # return redirect_to preview_path
    end

end
