class CustomerMailer < ActionMailer::Base
  default from: "customer.service@bigtv.co.id"

  def thanks_email(order)
    prepare_order(order)
    mail(to: @user.email, subject: 'Terimakasih telah berlangganan BigTv')
  end

  def email_order_to_admin(order)
    prepare_order(order)
    mail(to: 'verifikasi.online@gmail.com', subject: "REGISTERED, #{@user.code}, #{@user.profile.full_name}")
  end

  def payment_email(order, payment)
    prepare_order(order)
    @payment = payment
    mail(to: @user.email, subject: "Notifikasi Pembayaran BigTv #{@order.code}")
  end

  def payment_email_admin(order, payment)
    prepare_order(order)
    @payment = payment
    mail(to: 'verifikasi.online@gmail.com', subject: "PAIDREGISTERED, #{@user.code}, #{@user.profile.full_name}, #{@payment.transaction_no}")
  end

  def atm_payment_instruction(order, payment_code)
    prepare_order(order)
    @payment_code = payment_code
    mail(to: @user.email, bcc: 'verifikasi.online@gmail.com', subject: "Instruksi Pembayaran ##{@order.code}")
  end

  private

    def prepare_order(order)
      @user = order.orderable
      @order = order
      @url  = 'http://big-tv.com/'
      attachments.inline['bigtv.png'] = File.read("#{Rails.root}/vendor/assets/images/bigtv.png")
    end

end
