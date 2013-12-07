class UnitItemsController < ResourcesController
  before_filter :prepare_select, only: [:new, :edit]
  
  private
    def prepare_select
      @group_items = GroupItem.all
    end
end