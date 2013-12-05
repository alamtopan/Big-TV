class GroupItemsController < InheritedResources::Base
  before_filter :prepare_select, only: [:new,:edit]

  private
    def prepare_select
      @unit_item = UnitItem.all
    end
end