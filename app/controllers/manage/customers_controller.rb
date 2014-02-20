class Manage::CustomersController < Manage::ResourcesController # Menggunakan fungsi yang ada di resource controller/induk controller
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Customer, :collection_name => 'customers', :instance_name => 'customer'

  # Override fungsi index/crud
  def index
  	@customers = Customer.order('id ASC')
  end

end