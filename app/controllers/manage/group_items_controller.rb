class Manage::GroupItemsController < Manage::ResourcesController # Menggunakan fungsi yang ada di resource controller/induk controller
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => GroupItem, :collection_name => 'group_items', :instance_name => 'group_item'
  before_filter :prepare_select, only: [:new,:edit,:update,:create]

  private
  	# Fungsi pembantu untuk select unit item
    def prepare_select
      @unit_items = UnitItem.where('free = ?', false)
    end
end