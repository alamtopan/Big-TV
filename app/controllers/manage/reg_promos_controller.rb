class Manage::RegPromosController < Manage::ResourcesController # Menggunakan fungsi yang ada di resource controller/induk controller
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => RegPromo, :collection_name => 'reg_promos', :instance_name => 'reg_promo'
end

