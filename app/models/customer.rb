class Customer < User
  attr_accessible :captcha, :captcha_key
  before_validation :before_validation
  apply_simple_captcha

  private
    def before_validation
      unless self.password
        self.password = Devise.friendly_token[0,20]
        self.password_confirmation = self.password
      end
      self.username = "#{rand(Time.now.to_i)}" unless self.username
    end
end
