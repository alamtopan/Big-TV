class CartsController < ApplicationController
  layout "detail"
  before_filter :authorize_customer

  def extra
    @title_page = "Extra"
    display_extra_data = false
    if request.xhr? && params[:extra_id].present?
      order_item = order.items.find_by_membership_id(params[:extra_id])
      if params[:add].to_s == 'true' && !order_item
        extra_package = Membership.find_by_id(params[:extra_id])
        order.add_item(extra_package,session_cart) if extra_package
      elsif order_item
        order_item.destroy
      end
    elsif params[:membership_id].present? || session[:current_premium_id]
      current_premium_id = params[:membership_id].present? ? params[:membership_id] : session[:current_premium_id]
      item = Membership.find_by_id(current_premium_id)
      order.add_item(item, session_cart)
      display_extra_data = true
    elsif order.items.premium.present?
      display_extra_data = true
    else
      flash[:alert] = 'Mohon pilih salah satu paket premium!'
      redirect_to premium_path
    end
    
    if display_extra_data
      premium_item = order.items.premium
      if premium_item 
        if premium_item.title !~ /universe/i
          @memberships = Membership.includes(:unit_items,:category).
                          where('id IN (?)', Membership.extra_by_order(order).map(&:id)).
                          by_position
        else
          order.items.extras.destroy_all
        end
      end

      unless @memberships
        redirect_to rental_path
      end
    end
      
  end

  def premium
    @title_page = "Premium"
    if request.referer.to_s =~ /customer/i && order.items.present?
      redirect_to extra_path
    else
      @memberships = Membership.packages_by_category('premium')
      @groups = GroupItem.includes(unit_items: [:memberships]).all
    end
  end

  def preview
    @title_page = "More Info"
    if order.items.select{|i| i.premium? }.blank?
      redirect_to premium_path
    elsif order.total.to_i < 1
      redirect_to root_path
    end
    @referal = [['Hypermart', 'Hypermart'], ['Matahari', 'Matahari'],
                ['Dealer', 'Dealer'],
                ['Koran/Billboard', 'Koran/Billboard'],
                ['Pelanggan BigTV','Pelanggan BigTV'],
                ['SPG','SPG'],
                ['Others', 'Others']];
  end

  def rental_box
    @title_page = "Sewa Dekoder"
    @memberships = Membership.packages_by_category('other')
    @upgrades = Membership.where('name LIKE ? OR name LIKE ?', '%universe%', '%star%')

    @order  = order
    if order.items.where('membership_id IN (?)', @memberships.map(&:id)).blank?
      single_decoder = @memberships.where('memberships.name LIKE ?','1 %').first
      order.add_item(single_decoder, session_cart)
    end
  end

  def subcribe
    customer_info = params[:user] || params[:customer]
    if customer_info.blank?
      flash[:errors] = "Silahkan isi aplikasi pendaftaran dengan benar"
      if request.xhr?
        render json: {error: 'Invalid Parameters', redirect_url: preview_path}, status: :unprocessable_entity
      else
        redirect_to preview_path
      end
    else
      #user = Customer.find_or_initialize_by_email(params[:user][:email])
      customer_info.delete(:password)
      customer_info.delete(:password_confirmation)
      customer_info.delete(:username)
      @customer = @order.orderable
      
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
        
        @words = Digest::SHA1.hexdigest("#{"%.2f" % order.grand_total}#{ENV['MALL_ID']}#{ENV['SHARED_KEY']}#{order.code}")
        @payment_method = params[:payment_method]
        delete_session
        unless request.xhr?
          redirect_to thanks_path(token: order.token)
        end
      else
        flash[:errors] = @customer.errors.full_messages
        unless request.xhr?
          redirect_to preview_path
        end
      end
    end
  end

  def create
    if params[:membership_id].present?
      unless check_decoder_membership(params[:membership_id])
        return redirect_to rental_path
      end
    end
    if params[:membership_ids].present?
      check_order(order,params[:membership_ids].unshift(session[:current_premium_id]).compact.uniq)
      path_redirect = rental_path
      package_created = params
    else
      check_order(order,params[:membership_id])
      path_redirect = preview_path
      package_created = Membership.find(params[:membership_id])
    end
    order.add_item(package_created,session_cart)
    if order.errors.blank?
      session.delete(:current_premium_id)
      redirect_to path_redirect
    else
      render action: :extra
    end
  end

  def update_package
    order.items.each do |item|
      if item.premium?
        item.destroy
      end
    end
    new_package = Membership.where("name LIKE ?", "%Star%").first
    order.add_item(new_package,session_cart)
    redirect_to rental_path
  end

  def update
    redirect_to preview_path if order.update_attributes(params[:order])
  end

  def destroy
    if product
      cart_item = order.items.find_by_product_id(product.id)
      cart_item.destroy if cart_item
    end
    redirect_to preview_path
  end

  private
    def product
      @product ||= Membership.find(params[:id])
    end

    def delete_session
      cart = cookies[:cart_id]
      session = ActiveRecord::SessionStore::Session.find_by_session_id(cart)
      session.delete if session.present?
      sign_out(:customer)
      cookies.delete :cart_id
    end

    def save_order
      period = params[:order][:period].to_i
      order.session_id = nil
      order.period = period
      order.period_name = 'month'
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

    def authorize_customer
      @order = Order.find_by_token(params[:token]) if params[:token].present?

      session[:current_premium_id] = params[:membership_id] if params[:membership_id].present?
      unless order.orderable
        if request.xhr?
          render json: {error: 'Unauthorized Access', redirect_url: new_customer_path}, status: 401
        else
          redirect_to(new_customer_path) and return
        end
      end
    end

end
