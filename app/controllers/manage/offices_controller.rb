class Manage::OfficesController < Manage::ResourcesController # Menggunakan fungsi yang ada di resource controller/induk controller
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Office, :collection_name => 'offices', :instance_name => 'office'
  before_filter :prepare_select

  # Override fungsi index/crud
  def index
  	@offices = Office.order('id ASC')
  end

  private

  # Fungsi pembantu untuk select kategori office dan regional
  def prepare_select
  	@cate_office = CategoryOffice.order("name")
  	@reg_office = Regional.order("name")
  end
end

