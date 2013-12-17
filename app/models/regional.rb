class Regional < ActiveRecord::Base
  attr_accessible :name
  has_many :offices
end
