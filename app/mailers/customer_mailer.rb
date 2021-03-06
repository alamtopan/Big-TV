class CustomerMailer < ActionMailer::Base
  default from: "noreply@bigtv.co.id"

  def reg_promo(reg_promo)
    icon_bigtv
    @reg_promo = reg_promo
    mail(to: 'online.bigtv@gmail.com', subject: "{ONLINE} Registrasi #{@reg_promo.subject}, #{@reg_promo.name}")
  end

  def thanks_promo(reg_promo)
    icon_bigtv
    @reg_promo = reg_promo
    mail(to: "#{@reg_promo.email}", subject: "Terima kasih telah mendaftar")
  end

  def service_request(service)
    icon_bigtv
    @service = service
    mail(to: 'customer.service@bigtv.co.id', subject: "{ONLINE} Service Request, #{@service.problem}, #{@service.name}")
  end

  def thanks_service(service)
    icon_bigtv
    @service = service
    mail(to: "#{@service.email}", subject: "Terima kasih telah menghubungi BigTV")
  end

  def job_request(job_applicant)
    icon_bigtv
    @job_applicant = job_applicant
    begin
      if @job_applicant.file_resume.present? && File.exist?(@job_applicant.file_resume.path)
        attachments[@job_applicant.file_resume_file_name] = File.read(@job_applicant.file_resume.path)
      end
    rescue
    end
    mail(to: 'hrd@big-tv.com', subject: "Job Applicant, #{@job_applicant.job.position}, #{@job_applicant.name}")
  end

  def thanks_email(order)
    prepare_order(order)
    mail(to: @user.email, subject: 'Terima kasih telah berlangganan BigTv')
  end

  def welcome_email(user)
    prepare_user(user)
    mail(to: @user.email, subject: 'Terima kasih telah bergabung dengan BigTv')
  end

  def welcome_email_admin(user)
    prepare_user(user)
    mail(to: 'online.bigtv@gmail.com', subject: "REGISTERED, #{@user.code}, #{@user.profile.full_name}")
  end

  def email_order_to_admin(order)
    prepare_order(order)
    mail(to: 'verifikasi.online@gmail.com', subject: "UNPAIDREGISTERED, #{@user.code}, #{@user.profile.full_name}")
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

    def prepare_user(user)
      @url  = 'http://big-tv.com/'
      @user = user
      attachments.inline['bigtv.png'] = File.read("#{Rails.root}/vendor/assets/images/bigtv.png")
    end

    def icon_bigtv
      attachments.inline['bigtv.png'] = File.read("#{Rails.root}/vendor/assets/images/bigtv.png")
    end

    def prepare_order(order)
      prepare_user(order.orderable)
      @order = order
    end

end
