class Payment < ActiveRecord::Base
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
     payment.total          = options[:AMOUNT].to_f

     order.status = options[:VERIFYSTATUS]
     if payment.save && order.save
      CustomerMailer.delay.payment_email(order, payment)
      CustomerMailer.delay.email_order_to_admin(order)
      return true
    else
      return false
    end
  end

end
