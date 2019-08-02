# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, [User, Group, Survey], company_id: user.company_id
      cannot [:destroy, :edit], user
    elsif user.supervisor?
      can :read, [User, Group, Survey], company_id: user.company_id
    elsif user.member?

    else
      
    end
  end
end
