class PublicsController < ApplicationController
  layout "public"

	def show
		if params[:regional] 
			regional = params[:regional]
		else 
			regional = "Sumatra"	
		end
		@locations_google= Office.packages_by_map(regional)
		@locations_hypermart= Office.packages_by_regional(regional,'Hypermart')
		@locations_mall= Office.packages_by_regional(regional,'Mall')
		@locations_dealer= Office.packages_by_regional(regional,'Dealer')
		
    @memberships = Membership.packages_by_category('premium')
    @groups = GroupItem.all
    @free_channels = UnitItem.where('free = ?', true)
	end

  def thanks
  render layout: "detail"  
  end

end
