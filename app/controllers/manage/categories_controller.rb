class Manage::CategoriesController < Manage::ResourcesController # Menggunakan fungsi yang ada di resource controller/induk controller
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Category, :collection_name => 'categories', :instance_name => 'category'
end