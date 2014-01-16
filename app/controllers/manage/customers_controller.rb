class Manage::CustomersController < Manage::ResourcesController
  defaults :resource_class => Customer, :collection_name => 'customers', :instance_name => 'customer'
end