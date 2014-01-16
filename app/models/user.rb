class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  after_initialize :after_initialized

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :profile_attributes
  # attr_accessible :title, :body

  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile, reject_if: :all_blank

  # default_scope where('code IS NULL').order('updated_at DESC')
  
  def full_name
    return '' unless profile
    profile.full_name
  end

  protected
    def after_initialized
      self.profile = Profile.new if self.profile.blank?
    end
end
