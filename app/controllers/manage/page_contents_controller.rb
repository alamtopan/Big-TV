class Manage::PageContentsController <  Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
	defaults :resource_class => PageContent, :collection_name => 'page_contents', :instance_name => 'page_content'
end