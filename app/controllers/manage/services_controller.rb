class Manage::ServicesController < Manage::ResourcesController # Menggunakan fungsi yang ada di resource controller/induk controller
	skip_load_and_authorize_resource only: :index
	defaults :resource_class => Service, :collection_name => 'services', :instance_name => 'service'
	before_filter :choice


	private
		# Fungsi tambahan untuk redio button di service request
		def choice
			@problem 			= [
												 'Gambar sering kabur atau muncul tulisan No Signal',
												 'Di dalam layar terdapat tulisan "Access Danied" atau "Card Not Paired"',
												 'Box tidak menyala',
												 'Masalah lainnya'
											]

			@program 			= ['Pre Paid','Post Paid']
			@day_problem  =	['1-2 Hari','3-7 Hari','8-15 Hari']
			@status				= ['IN PROGRESS','DONE','FAILED']

		end
end