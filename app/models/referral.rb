class Referral < User
	before_validation	:before_validating
	after_save				:after_saving
	attr_accessible :code
  
  belongs_to :referral_category

	def orders
		Order.includes(:user => [:profile]).
		      where(['profiles.referal_id = ?', self.code]).
		      where('session_id IS NULL')
	end

	private
		def before_validating
			unless self.password
				self.password = Devise.friendly_token(0,20)
				self.password_confirmation = self.password
			end if self.new_record?
			self.username = "#{rand(Time.now.to_i)}" unless self.username
		end

		def after_saving
			self.update_column(:code, "%.10d" % self.id) if self.code.blank?
		end
end