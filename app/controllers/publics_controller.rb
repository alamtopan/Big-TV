class PublicsController < ApplicationController
	layout "public"

	def home
    @memberships = Membership.package('premium')
    @groups = GroupItem.all
	end

  def extra
    @memberships = Membership.package('extra')
  end

end