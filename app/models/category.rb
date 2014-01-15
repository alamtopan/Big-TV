class Category < ActiveRecord::Base
  attr_accessible :name
  has_one :membership

  before_validation :before_validating
  validates_uniqueness_of :name
  validates_presence_of  :name
  
  module Config
    NAMES=['premium','extra','other','ez']
  end

  private
    def before_validating
      self.name.downcase! if self.name
    end
end
