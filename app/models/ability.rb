class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.admin?
      can [:read, :create, :update, :destroy], [User, Group], company_id: user.company_id
      can [:calculate_surveys], User, company_id: user.company_id
      can [:edit, :update], UserSetting, user_id: user.id
      can [:edit, :update], CompanySetting, company_id: user.company_id
      can [:read, :create, :update, :destroy, :edit, :new, :add_question, :add_option, :delete_question, :delete_option, :survey_charts], Survey, company_id: user.company_id
      can [:read, :create], UserResponse, company_id: user.company_id
      cannot [:destroy], user
    elsif user.supervisor?
      can [:update, :edit], user
      can :read, User, company_id: user.company_id, role: User::ROLE[:member]
      can [:edit, :update], UserSetting, user_id: user.id if user.company.company_setting.supervisors_settings_permission?
      can :read, Group, company_id: user.company_id
      can :calculate_surveys, User, company_id: user.company_id
      can [:read, :create, :update, :destroy, :edit, :new, :add_question, :add_option, :delete_question, :delete_option, :survey_charts], Survey, company_id: user.company_id if user.company.company_setting.supervisors_survey_permission?
      can [:read, :create], UserResponse, company_id: user.company_id
    elsif user.member?
      can [:update, :edit], user
      can [:edit, :update], UserSetting, user_id: user.id if user.company.company_setting.members_settings_permission?    
      can :calculate_surveys, User, company_id: user.company_id
      can [:read], Survey
      can [:create], UserResponse
    else
      can [:read], Survey
      can [:create], UserResponse
    end
  end
end