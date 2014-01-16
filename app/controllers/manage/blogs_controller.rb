class Manage::BlogsController < Manage::ResourcesController
  defaults :resource_class => Blog, :collection_name => 'blogs', :instance_name => 'blog'
end

