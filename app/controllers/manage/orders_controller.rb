class Manage::OrdersController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Order, :collection_name => 'orders', :instance_name => 'order'
end