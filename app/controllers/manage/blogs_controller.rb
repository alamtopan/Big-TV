class Manage::BlogsController < Manage::ResourcesController # Menggunakan fungsi yang ada di resource controller/induk controller
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Blog, :collection_name => 'blogs', :instance_name => 'blog'
end

