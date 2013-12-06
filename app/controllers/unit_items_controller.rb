class UnitItemsController < InheritedResources::Base
  before_filter :prepare_select, only: [:new, :edit]

  def index  
    @unit_items = UnitItem.page()  
  end

  def create  
    create! { unit_items_path }  
  end  

  def update  
    update! { unit_items_path }  
  end  

  def prepare_select
    @group_id = GroupItem.all
  end
end