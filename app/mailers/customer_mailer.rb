class CustomerMailer < ActionMailer::Base
  default from: "customer.service@bigtv.co.id"

  def thanks_email(order)
    @user = order.orderable
    @order = order
    @url  = 'http://bigtv.co.id/'
    attachments.inline['bigtv.png'] = File.read("#{Rails.root}/vendor/assets/images/bigtv.png")
    mail(to: @user.email, subject: 'Thanks For Subscribing')
  end
end
