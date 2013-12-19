class Office < ActiveRecord::Base
  attr_accessible :name,:address,:phone_area,:no_phone,:no_fax,:longitude,:latitude,
                  :category_office_id, :regional_id
  belongs_to :category_office
  belongs_to :regional

  class << self
    def packages_by_map(_package)
      includes(:regional).where(['regionals.name = ?', _package])
    end

    def packages_by_regional(_package,_package2)
      includes(:regional,:category_office).where(['regionals.name = ? and category_offices.name = ?', _package,_package2])
    end
    
    def other_packages
      joins(:regional).where('regionals.name LIKE ? and category_offices.name LIKE ?','%other%')
    end
  end

end
