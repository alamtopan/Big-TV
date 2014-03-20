# Induk controller dan semua controller di halaman Backend mengarah kesini
class Manage::ResourcesController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :authorize_index

  # Override Fungsi create all controller
  def create  
    create! do |success, failure|
      success.html { redirect_to collection_path }
    end
  end  

  # Override Fungsi update all controller
  def update  
    update! do |success, failure|
      success.html { redirect_to collection_path }
    end
  end  

  protected
    # Fungsi untuk paginasi data
    def per_page
      params[:per_page] ||= 2
    end

    def page
      params[:page] ||= 1
    end

    # Fungsi collection data
    def collection
      get_collection_ivar || set_collection_ivar(end_of_association_chain.accessible_by(current_ability).page(page).per(per_page))
    end

    # Fungsi authorize user
    def authorize_index
      unless can?(:index, end_of_association_chain)
        raise CanCan::AccessDenied
      end if end_of_association_chain
    end
end