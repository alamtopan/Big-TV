class Manage::UnitItemsController < Manage::ResourcesController
	skip_load_and_authorize_resource only: :index
  defaults :resource_class => UnitItem, :collection_name => 'unit_items', :instance_name => 'unit_item'
  before_filter :prepare_select, only: [:new, :edit]
  
  private
    def prepare_select
      @group_items = GroupItem.all
    end
end