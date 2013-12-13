class PublicsController < ApplicationController
	layout "public"

	def show
    @memberships = Membership.packages_by_category('premium')
    @groups = GroupItem.all
	end

  def thanks
    
  end

end
