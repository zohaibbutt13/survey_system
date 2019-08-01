# frozen_string_literal: true
class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, [User, Group, Survey], company_id: user.company_id
      can :manage, UserSetting, user_id: user.id
      can :manage, CompanySetting, company_id: user.company_id
      cannot [:destroy, :edit], user
    elsif user.supervisor?
      can :manage, UserSetting, user_id: user.id if user.company.company_setting.supervisors_settings_permission?
      can :read, [User, Group], company_id: user.company_id
    elsif user.member? 
      can :manage, UserSetting, user_id: user.id if user.company.company_setting.members_settings_permission?    
    end
  end
end