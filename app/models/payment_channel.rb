class PaymentChannel

  CREDIT_CARD = '01'
  DOKU_WALLET = '02'
  ATM         = '05'

  def initialize(payment_channel = '')
    @payment_channel = payment_channel
  end

  constants.each do |const|
    define_method("#{const.to_s.downcase}?") do
      self.class.const_get(const) == @payment_channel
    end
  end

  def self.constants_by_value(val)
    constants.find{|const| const_get(const) == val }
  end
end