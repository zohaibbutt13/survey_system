class CompaniesController < ApplicationController  
  before_action :authenticate_user! do
    @user = current_user
    @company = @user.company
  end

  #TODO after_create
  #.................
  
  def dashboard
    @company_setting, @user_setting = @company.dashboard_resources(@user)
  end
end