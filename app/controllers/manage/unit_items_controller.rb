class Manage::UnitItemsController < Manage::ResourcesController # Menggunakan fungsi yang ada di resource controller/induk controller
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => UnitItem, :collection_name => 'unit_items', :instance_name => 'unit_item'
  before_filter :prepare_select, only: [:new, :create, :edit, :update]

  # Overrid fungsi index/crud
  def index
  	@unit_items = UnitItem.order('id ASC')
  end
  
  private
    # Fungsi tambahan untuk select group items
    def prepare_select
      @group_items = GroupItem.all
    end
end