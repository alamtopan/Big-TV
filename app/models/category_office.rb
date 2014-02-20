class CategoryOffice < ActiveRecord::Base
  attr_accessible :name # Attributess kategori office
  has_many :offices # Mempunyai banyak office
end
