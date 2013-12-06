class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :profile_attributes
  # attr_accessible :title, :body

  has_one :profile, :foreign_key => "user_id", :dependent => :destroy

  accepts_nested_attributes_for :profile, :reject_if => :all_blank, allow_destroy: true

  validates :username, :uniqueness => true
  validates :username, :presence => true
end
