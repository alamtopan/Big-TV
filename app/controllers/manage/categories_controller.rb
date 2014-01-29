class Manage::CategoriesController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Category, :collection_name => 'categories', :instance_name => 'category'
end