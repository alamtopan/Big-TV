class Manage::OrdersController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Order, :collection_name => 'orders', :instance_name => 'order'

  def new
  	@memberships   = Membership.packages_by_category('premium')
    @groups        = GroupItem.includes(unit_items: [:memberships]).by_position
  end
end