class Ability
  include CanCan::Ability
  attr_accessor :current_user

  def initialize(user)
    alias_action :create, :read, :update, :destroy, :to => :crud
    self.current_user = user
    unless user
      cannot :manage, :all
    else
      referral_abilities(user) if user.is_a?(Referral)
      customer_abilities(user) if user.is_a?(Customer)
      admin_abilitties if user.type.blank?
    end
  end

  def referral_abilities(user) # Hak Akses untuk SPG Hanya bisa manage Order dan data dirinya
    can [:read, :create], Order
    can [:read, :update], User, id: user.id
  end

  def customer_abilities(user)
    can :read, Order, Order
  end
  
  def admin_abilitties # Hak Akses untuk admin bisa manage semua data
    can :manage, :all
  end
end