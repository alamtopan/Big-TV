class Manage::JobsController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Job, :collection_name => 'jobs', :instance_name => 'job'
end