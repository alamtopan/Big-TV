if Rails.env =~ /production|staging/i
  BigTv::Application.config.middleware.use ExceptionNotifier,
    :email_prefix => "[BigTv Error] ",
    :sender_address => 'noreply@big-tv.com',
    :exception_recipients => ['yacobus@domikado.com', 'alam.topani@domikado.com']
end
