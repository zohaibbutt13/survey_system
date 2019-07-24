# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.present?
      if user.admin?
        can :manage, UserSetting, user_id: user.id
        can :manage, CompanySetting, company_id: user.company_id
      end
      if user.supervisor?
        can :manage, UserSetting, user_id: user.id if user.company.company_setting.supervisors_settings_permission?
      end
      if user.member? 
        can :manage, UserSetting, user_id: user.id if user.company.company_setting.members_settings_permission?    
      end
    end
  end
end