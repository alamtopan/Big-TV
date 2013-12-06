class MembershipsController < InheritedResources::Base

  def index  
    @memberships = Membership.page()  
  end

end