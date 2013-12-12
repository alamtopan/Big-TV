class PublicsController < ApplicationController
	layout "public"

	def show
    @memberships = Membership.package('premium')
    @groups = GroupItem.all
	end

  def thanks
    
  end

end