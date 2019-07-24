class CompaniesController < ApplicationController
  before_action :authenticate_user! do
    @user = current_user
  end

  def dashboard
    @companies = Company.find(@user.company_id)
    #/layouts/_header
    @company_settings = CompanySetting.find_by_company_id(current_user.company_id)
    #/Companies/Dashboard
    @user_settings = UserSetting.find_by_user_id(current_user.id)
  end
end