class GroupItemsController < ResourcesController
  before_filter :prepare_select, only: [:new,:edit,:update,:create]

  private
    def prepare_select
      @unit_items = UnitItem.where('free = ?', false)
    end
end