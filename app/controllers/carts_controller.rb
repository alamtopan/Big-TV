class CartsController < ApplicationController
  layout "public"

  def extra
    @memberships = Membership.package('extra')
  end

  def preview
    redirect_to root_path if order.total.blank?
    decoder = Membership.joins(:category).where('categories.name LIKE ?','%other%').first
    if decoder
      decoder_item = order.items.find_or_initialize_by_membership_id(decoder.id)
      order.add_item(decoder) if decoder_item.new_record?
    end
    @order = order
  end

  # def index
  #   order
  # end

  def subcribtions
    if params[:user].blank?
      flash[:errors] = "Please Fill The Form"
      redirect_to preview_path
    else
      user = User.new(params[:user])
      if user.save
        flash[:success] = 'success'
        # do subscribe
      else
        flash[:errors] = user.errors
        redirect_to preview_path
      end
    end
  end

  def create
    order.add_item(params)
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

end