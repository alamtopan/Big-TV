class Office < ActiveRecord::Base
  attr_accessible :name,:address,:phone_area,:no_phone,:no_fax,:longitude,:latitude,
                  :category_office_id, :regional_id
  belongs_to :category_office
  belongs_to :regional

end
