class Manage::PageContentsController <  Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
	defaults :resource_class => PageContent, :collection_name => 'page_contents', :instance_name => 'page_content'
	before_filter :category_content

	private
		def category_content
	  	@category_contents = [
												      ['Slogan Bigtv', 'Slogan Bigtv'],
												      ['Slider Top', 'Slider Top'],
												      ['Fitur Content', 'Fitur Content'],
												      ['Tab Why BigTV', 'Tab Why BigTV'],
												      ['Tab Support Content', 'Tab Support Content'], 
												      ['Footer Content', 'Footer Content'],
												      ['Footer About Bigtv', 'Footer About Bigtv'],
												      ['Single Page', 'Single Page']
												    ]
	 	end
end