class Manage::MembershipsController < Manage::ResourcesController
  defaults :resource_class => Membership, :collection_name => 'memberships', :instance_name => 'membership'
  prepend_before_filter :prepare_save, only: [:create, :update]
  before_filter :prepare_select, except: [:index]
  
  private
    def prepare_select
      @categories = Category.all
      @group_items = GroupItem.all
      @periode_name =  MembershipPrice.periode_name.values
    end

    def prepare_save
      params[:membership][:unit_item_ids] = [] unless params[:membership][:unit_item_ids]
    end
end