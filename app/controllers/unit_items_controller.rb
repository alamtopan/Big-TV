class UnitItemsController < InheritedResources::Base
  before_filter :prepare_select, only: [:new, :edit]

  def prepare_select
    @group_id = GroupItem.all
  end
end