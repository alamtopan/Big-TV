class PublicsController < ApplicationController
  layout "public"

	def show
    @memberships = Membership.packages_by_category('premium')
    @groups = GroupItem.all
    @free_channels = UnitItem.where('free = ?', true)
	end

  def thanks
  render layout: "detail"  
  end

end
