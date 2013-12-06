class MembershipPricesController < InheritedResources::Base
  before_filter :prepare_select, only: [:new, :edit]
  
  def index  
    @membership_prices = MembershipPrice.page()  
  end

  def create  
    create! { membership_prices_path }  
  end  

  def update  
    update! { membership_prices_path }  
  end
  
  def prepare_select
    @membership_id = Membership.all
    @periode_name = [["Day","day"],["Week","week"],["Month","month"],["Year","year"]]
  end
end