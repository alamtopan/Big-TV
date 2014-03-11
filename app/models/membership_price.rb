class MembershipPrice < ActiveRecord::Base
  extend Enumerize
  enumerize :periode_name, in: [:day, :week, :month, :year], default: :month

  attr_accessible :price, :total_period, :periode_name, :membership_id # Attributess membership price
  
  with_options(presence: true) do |presence|
    presence.validates :periode_name
    # presence.validates :membership_id
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

  def periode_name_bahasa
    periode_name.to_s.gsub(/month/i,'bulan').gsub(/year/i, 'tahun')
  end

  def total_period_bahasa
    ["per", "#{total_period.to_s.gsub(/^1$/,'')}"].select(&:'present?').join(' ')
  end

  def total_period_in_month
    total_month = periode_name.to_s == 'year' ? 12 : 1
    total_period.to_i * total_month
  end
end
