class Manage::OfficesController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => Office, :collection_name => 'offices', :instance_name => 'office'
  before_filter :prepare_select

  def index
  	@offices = Office.order('id ASC')
  end

  private

  def prepare_select
  	@cate_office = CategoryOffice.order("name")
  	@reg_office = Regional.order("name")
  end
end

