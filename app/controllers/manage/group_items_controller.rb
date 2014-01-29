class Manage::GroupItemsController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => GroupItem, :collection_name => 'group_items', :instance_name => 'group_item'
  before_filter :prepare_select, only: [:new,:edit,:update,:create]

  private
    def prepare_select
      @unit_items = UnitItem.where('free = ?', false)
    end
end