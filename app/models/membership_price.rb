class MembershipPrice < ActiveRecord::Base
  extend Enumerize
  enumerize :periode_name, in: [:day, :week, :month, :year], default: :month

  attr_accessible :price, :total_period, :periode_name, :membership_id
  
  with_options(presence: true) do |presence|
    presence.validates :periode_name
    presence.validates :membership_id
    presence.with_options(numericality: {integer: true}) do |numericality|
      numericality.validates :total_period
    end
  end
  
  belongs_to :membership

  def periode_time
    "#{total_period} #{periode_name}"
  end

  def to_time
    total_period.send(periode_name)
  end
end
