# frozen_string_literal: true
class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin?
      can [:edit, :update], UserSetting, user_id: user.id
      can [:edit, :update], CompanySetting, company_id: user.company_id 
      can [:read, :create, :update, :destroy], [User, Group, Survey], company_id: user.company_id
      cannot [:destroy, :edit], user
    elsif user.supervisor?
      can :read, User, company_id: user.company_id, role: User::ROLE[:member]
      can [:edit, :update], UserSetting, user_id: user.id if user.company.company_setting.supervisors_settings_permission?
      can :read, Group, company_id: user.company_id
    elsif user.member? 
      can [:edit, :update], UserSetting, user_id: user.id if user.company.company_setting.members_settings_permission?    
    end
  end
end