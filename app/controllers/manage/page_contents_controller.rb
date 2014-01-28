class Manage::PageContentsController <  Manage::ResourcesController
	defaults :resource_class => PageContent, :collection_name => 'page_contents', :instance_name => 'page_content'
end