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

    @memberships   = Membership.packages_by_category('premium')
    @memberships_extra = Membership.packages_by_category('extra')
    @groups        = GroupItem.includes(unit_items: [:memberships]).all
    @free_channels = UnitItem.where('free = ?', true)
	end

  def thanks
    if params[:token].present? && @order = Order.find_by_token(params[:token])
      @customer         = @order.orderable
      @customer_profile = @customer.profile
      render layout: 'detail'
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
