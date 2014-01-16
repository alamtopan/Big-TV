class Manage::OrdersController < Manage::ResourcesController
  defaults :resource_class => Order, :collection_name => 'orders', :instance_name => 'order'
end