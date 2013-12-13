class CartsController < ApplicationController
  layout "public"

  def extra
    @memberships = Membership.packages_by_category('extra')
    @order = order
  end

  def preview
    redirect_to root_path if order.total.blank?
    decoder = Membership.joins(:category).where('categories.name LIKE ?','%other%').first
    if decoder
      decoder_item = order.items.find_or_initialize_by_membership_id(decoder.id)
      order.add_item(decoder,session_cart) if decoder_item.new_record?
    end

    @order = order
  end

  # def index
  #   order
  # end

  def subcribe
    if params[:user].blank?
      flash[:errors] = "Please Fill The Form"
      redirect_to preview_path
    else
      user = Customer.find_or_initialize_by_email(params[:user][:email])
      user.update_attributes(params[:user])
      if user.save
        save_order(user)
        flash[:success] = 'success'
        CustomerMailer.thanks_email(order).deliver
        delete_session
        # do subscribe
        redirect_to thanks_path
      else
        flash[:errors] = user.errors.full_messages
        redirect_to preview_path
      end
    end
  end

  def create
    check_order(order,params[:membership_ids])
    order.add_item(params,session_cart)
    redirect_to preview_path if order.valid?
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
    def order
      @order ||= Order.find_or_create_by_session_id(session_cart)
    end

    def product
      @product ||= Membership.find(params[:id])
    end

    def delete_session
      cart = cookies[:cart_id]
      session = ActiveRecord::SessionStore::Session.find_by_session_id(cart)
      session.delete if session.present?
      cookies.delete :cart_id
    end

    def save_order(user)
      period = params[:order][:period].to_i
      order.orderable = user
      order.session_id = nil
      order.period = period
      order.period_name = 'month'
      order.save
    end

    def check_order(order,params_membership)
      order.items.each do |item|
        unless params_membership.include?(item.membership_id)
          item.delete
        end
      end
    end

    # def save_gatepay(order)
    #   gatepay = Gatepay.find_or_initialize_by_transid(order.code)
    #   gatepay.trxstatus = 'Pending'
    #   gatepay.save
    # end
    
    # def params_doku(order)
    #   total = order.total.round(2)
    #   params << params[:MALLID] = 958
    #   params << params[:CHAINMERCHANT] = 'NA'
    #   params << params[:AMOUNT] = order.total
    #   params << params[:PURCHASEAMOUNT] = order.total
    #   params << params[:TRANSIDMERCHANT] = order.code
    #   params << params[:WORDS] = generate_word(total,order.code)
    #   params << params[:REQUESTDATETIME] = DateTime.now.strftime('%Y%m%d%H%I%S') #datetime, YYYYMMDDHHMMSS
    #   params << params[:CURRENCY] = 360
    #   params << params[:PURCHASECURRENCY] = 360
    #   params << params[:SESSIONID] = #blmtau
    #   params << params[:NAME] = order.orderable.profile.first_name
    #   params << params[:EMAIL] = order.orderable.email
    #   params << params[:PAYMENTCHANNEL] = '04'
    #   params << params[:BASKET] = generate_basket(order)
    #   params
    # end

    # def generate_word(total,code)
    #   Digest::SHA1.hexdigest(total + 958 + '75Pi0aDrFBc0' + code)
    # end

    # def generate_basket(order)
    #   basket = ''
    #   order.items.each_with_index do |item,index|
    #     total = item.subtotal * order.periode
    #     basket += "#{item.title},#{item.subtotal},#{order.period},#{total}"
    #     basket += ";" if index != (order.items.count - 1)
    #   end
    #   basket
    # end

end