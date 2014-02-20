class Regional < ActiveRecord::Base
  attr_accessible :name # Attributess tabel regional
  has_many :offices # Mempunyai banyak offices
end
