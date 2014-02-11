class Manage::CategoryOfficesController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => CategoryOffice, :collection_name => 'category_offices', :instance_name => 'category_office'

end

