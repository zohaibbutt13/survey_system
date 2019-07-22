class CompaniesController < ApplicationController
	before_action :authenticate_user! do
	  @user = current_user
	  #@company = @user.company
  end

  def dashboard
    @companies = Company.find(@user.company_id);
  end
end