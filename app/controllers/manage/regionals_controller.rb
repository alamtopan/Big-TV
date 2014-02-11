class Manage::RegionalsController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Regional, :collection_name => 'regionals', :instance_name => 'regional'

end

