class Customer < User
  before_validation :before_validation
  after_create :after_creation

  private
    def before_validation
      unless self.password
        self.password = Devise.friendly_token[0,20]
        self.password_confirmation = self.password
      end
      self.username = "#{rand(Time.now.to_i)}" unless self.username
    end

    def after_creation
      UserMailer.welcome_email(self).deliver
    end
end
