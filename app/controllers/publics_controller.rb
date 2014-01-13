class PublicsController < ApplicationController
  layout "public"

	def show
		if params[:regional]
			regional = params[:regional]
		else
			regional = "Sumatra"
		end
    @blogs         = Blog.all
    @categories    = CategoryOffice.includes(offices: [:category_office, :regional]).all
    @regionals     = Regional.all

    @memberships   = Membership.includes(:prices).packages_by_category('premium')
    @groups        = GroupItem.includes(unit_items: [:memberships]).all
    @free_channels = UnitItem.where('free = ?', true)
	end

  def thanks
    @order = Order.find_by_code(session[params[:order_id]]) if session[params[:order_id]].present?
    # @order = Order.last
    if @order
      @customer = @order.orderable
      @customer_profile = @customer.profile
      render layout: "detail"
    else
      redirect_to root_path
    end
  end

  def render_map
    return unless params[:regional]
    regional = params[:regional]
    @locations_google= Office.packages_by_map(regional)
    render partial: 'map'
  end

  def decoder
  end

  def lokasi
    @categories= CategoryOffice.all
    @regionals= Regional.all
    render layout: "detail"
  end

  def cara_berlangganan
    render layout: "detail_lanjut"
  end

  def support
    render layout: "detail"
  end

  def show_blog
    @blog = Blog.find_by_id(params[:id])
    render layout: "detail"
  end

end
