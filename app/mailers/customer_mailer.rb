class CustomerMailer < ActionMailer::Base
  default from: "customer.service@bigtv.co.id"

  def thanks_email(order)
    prepare_order(order)
    mail(to: @user.email, subject: 'Terimakasih telah berlangganan BigTv')
  end

  def email_order_to_admin(order)
    prepare_order(order)
    mail(to: 'bigtv.complete@gmail.com', subject: 'Pending Subscription ')
  end

  def paid_email(order, payment)
    prepare_order(order)
    @payment = payment
    mail(to: @user.email, subject: 'Pemberitahuan Pembayaran BigTV')
  end

  def prepare_order(order)
    @user = order.orderable
    @order = order
    @url  = 'http://big-tv.com/'
    attachments.inline['bigtv.png'] = File.read("#{Rails.root}/vendor/assets/images/bigtv.png")
  end
end
