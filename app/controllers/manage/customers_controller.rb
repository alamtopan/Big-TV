class Manage::CustomersController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Customer, :collection_name => 'customers', :instance_name => 'customer'

  def index
  	@customers = Customer.order('id ASC')
  end

end