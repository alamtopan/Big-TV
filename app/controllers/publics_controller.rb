class PublicsController < ApplicationController
  layout "public"

	def show
		if params[:regional] 
			regional = params[:regional]
		else 
			regional = "Sumatra"	
		end
    @blogs = Blog.all
    @categories= CategoryOffice.all
    @regionals= Regional.all
		
    @memberships = Membership.packages_by_category('premium')
    @groups = GroupItem.all
    @free_channels = UnitItem.where('free = ?', true)
	end

  def thanks
    @order = Order.find_by_session_id(session_cart)
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

  def show_blog
    @blog = Blog.find_by_id(params[:id])
    render layout: "detail"
  end
  
end
