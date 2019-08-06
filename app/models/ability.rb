# frozen_string_literal: true
class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, [User, Group], company_id: user.company_id
      can [:create, :read, :edit, :update, :add_question, :add_option, :delete_question, :delete_option, :destroy], Survey, company_id: user.company_id
      
      cannot [:destroy, :edit], user, company_id: user.company_id
      can [:read, :create, :update, :destroy], [User, Group], company_id: user.company_id
      can :manage, UserSetting, user_id: user.id
      can :manage, CompanySetting, company_id: user.company_id
      can [:read, :create, :update, :destroy, :edit, :new, :add_question, :add_option, :delete_question, :delete_option], Survey, company_id: user.company_id
      can [:read, :create], UserResponse
      cannot [:destroy], user
    elsif user.supervisor?
      can :read, User, company_id: user.company_id, role: User::ROLE[:member]
      can :manage, UserSetting, user_id: user.id if user.company.company_setting.supervisors_settings_permission?
      can :read, Group, company_id: user.company_id
    elsif user.member? 
      can :manage, UserSetting, user_id: user.id if user.company.company_setting.members_settings_permission?    
    end
  end
end