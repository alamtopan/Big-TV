class PublicsController < ApplicationController
	layout "public"

	def home
    @memberships = Membership.package('premium')
    @groups = GroupItem.all
	end

	def order
	end

	def extra
	end

end