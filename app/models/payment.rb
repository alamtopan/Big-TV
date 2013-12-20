class Payment < ActiveRecord:Base
  belongs_to :order

  def self.track_payment(order, options, req_env)
     payment = Payment.new
     payment.order_id       = order.id
     payment.transaction_no = options[:PAYMENTCODE]
     payment.status         = options[:VERIFYSTATUS].to_s.upcase
     payment.bank_issuer    = options[:BANK]
     payment.credit_card    = options[:MCN]
     payment.track_record   = "#{options}"
     payment.access_record  = "#{req_env}"

     order.status = options[:VERIFYSTATUS]
     payment.save && order.save
  end

end
