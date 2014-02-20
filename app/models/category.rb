class Category < ActiveRecord::Base
  attr_accessible :name # Attributess model category
  has_one :membership # Mempunyai banyak membership

  before_validation :before_validating
  validates_uniqueness_of :name # Validation unique
  validates_presence_of  :name # Validation present
  
  module Config
    NAMES=['premium','extra','other','ez']
  end

  class << self
    Config::NAMES.each do |name_item|
      define_method("#{ name_item.downcase }") do
        find_by_name('premium')
      end
    end
  end

  private
    def before_validating
      self.name.downcase! if self.name
    end
end
