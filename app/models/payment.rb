class Payment < ActiveRecord::Base
  belongs_to :order

  def self.track_payment(order, options, req_env)
    payment_status = options[:RESPONSECODE] === '0000' ? Order::Status::SUCCESS : Order::Status::FAILED
    payment = Payment.new
    payment.order_id       = order.id
    payment.transaction_no = options[:PAYMENTCODE]
    payment.status         = payment_status
    payment.bank_issuer    = options[:BANK]
    payment.credit_card    = options[:MCN]
    payment.track_record   = "#{options}"
    payment.access_record  = "#{req_env}"
    payment.total          = options[:AMOUNT].to_f

    if payment.save && order.send("#{payment_status}!")
      if order.success?
        CustomerMailer.delay.payment_email(order, payment)
        CustomerMailer.delay.email_order_to_admin(order)
      end

      return true
    else
      return false
    end
  end

end
