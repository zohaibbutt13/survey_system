# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can [:read, :create, :update, :destroy], [User, Group], company_id: user.company_id
      can [:create, :read, :edit, :update, :add_question, :add_option, :delete_question, :delete_option, :destroy], Survey, company_id: user.company_id
      can [:read, :create], UserResponse
      cannot [:destroy, :edit], user, company_id: user.company_id
    elsif user.supervisor?
      can :read, [User, Group], company_id: user.company_id
    elsif user.member?

    else
      
    end
  end
end
