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
    @memberships_extra = Membership.packages_by_category('extra').by_position
    @groups        = GroupItem.includes(unit_items: [:memberships]).by_position
    @free_channels = UnitItem.free_channels

    @features  = PageContent.where("category =?", "Fitur Content").order('id ASC')
    @why_bigtv   = PageContent.where("category =?", "Tab Why BigTV").order('id ASC')
    
	end

  def thanks
    prepare_order_by_token
  end

  def payment_instruction
    prepare_order_by_token
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
    @title_page = "Lokasi"
    @categories= CategoryOffice.all
    @regionals= Regional.all
    render layout: "detail"
  end

  def cara_berlangganan
    @title_page = "Cara Berlangganan"
    render layout: "detail_lanjut"
  end

  def support
    @title_page = "Support"
    @supports   = PageContent.where("category =?", "Tab Support Content").order('id ASC')
    render layout: "detail"
  end

  def show_blog
    @blog = Blog.where(slug: params[:id]).first
    @title_page = "#{@blog.title}" if @blog
    render layout: "detail"
  end

  private
    def prepare_order_by_token
      if params[:token].present? && @order = Order.find_by_token(params[:token])
        @customer         = @order.orderable
        @customer_profile = @customer.profile
        render layout: 'detail'
      else
        redirect_to root_path
      end
    end

end
