class CartsController < ApplicationController
  layout "public"

  def extra
    @memberships = Membership.package('extra')
  end

  def preview
    @order = order
  end

  # def index
  #   order
  # end

  def create
    order.add_item(params)
    redirect_to preview_path if order.valid?
  end

  def update
    redirect_to carts_path if order.update_attributes(params[:order])
  end

  def destroy
    if product
      cart_item = order.items.find_by_product_id(product.id)
      cart_item.destroy if cart_item
    end
    redirect_to carts_path
  end

  private
    def order
      @order ||= Order.find_or_create_by_session_id(session_cart)
    end

    def product
      @product ||= Membership.find(params[:id])
    end

end