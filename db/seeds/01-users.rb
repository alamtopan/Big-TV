module SeedUser
  def self.seed
    user = User.find_or_initialize_by_email("admin@bigtv.com")
    user.username = "admin"
    user.password = "12345678"
    user.password_confirmation = "12345678"
    user.save!
  end
end