class MembershipPrice < ActiveRecord::Base
  
  attr_accessible :price, :total_period, :periode_name, :membership_id

  validates_presence_of   :periode_name
  
  belongs_to :membership

  def periode_time
    "#{total_period} #{periode_name}"
  end
end
