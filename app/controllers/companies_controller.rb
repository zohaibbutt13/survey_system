class CompaniesController < ApplicationController  
  before_action :authenticate_user! do
    @user = current_user
    @company = @user.company
  end

  def dashboard
    @company_setting, @user_setting = @company.dashboard_resources(@user, @company)
  end
end