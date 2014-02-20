class Customer < User # Turunan dari user model
  before_validation :before_validating
  after_save        :after_saving

  has_many :orders, as: :orderable

  # default_scope where('code IS NOT NULL').order('updated_at DESC')

  def reference_no
    return '' unless profile
    profile.referal_id
  end

  def reference_type
    return referral_category.name if referral_category
    return '' unless profile
    profile.referral_info
  end

  private
    def before_validating
      unless self.password
        self.password = Devise.friendly_token[0,20]
        self.password_confirmation = self.password
      end
      self.username = "#{rand(Time.now.to_i)}" unless self.username
    end

    def after_saving
      self.update_column(:code, "%.10d" % self.id) if self.code.blank?
    end
end
