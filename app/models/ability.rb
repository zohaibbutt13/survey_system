# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    if user.role == 'admin'
      can :edit, UserSetting
    elsif user.role == "supervisor" && user.company.company_setting.supervisors_settings_permission
      can :edit, UserSetting
    elsif user.role == "member" && user.company.company_setting.members_settings_permission
      can :edit, UserSetting    
    end
  end
end