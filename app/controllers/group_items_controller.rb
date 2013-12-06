class GroupItemsController < InheritedResources::Base
  before_filter :prepare_select, only: [:new,:edit]

  def index  
    @group_items = GroupItem.page()  
  end

  def create  
    create! { group_items_path }  
  end  

  def update  
    update! { group_items_path }  
  end  

  private
    def prepare_select
      @unit_item = UnitItem.all
    end
end