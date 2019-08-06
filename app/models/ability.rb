# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, [User, Group], company_id: user.company_id
      can [:create, :read, :edit, :add_question, :add_option, :delete_question, :delete_option], Survey, company_id: user.company_id
      can [:read], UserResponse, company_id: user.company_id
      cannot [:destroy, :edit], user
    elsif user.supervisor?
      can :read, [User, Group], company_id: user.company_id
    elsif user.member?

    else
      
    end
  end
end
