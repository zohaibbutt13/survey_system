class CompaniesController < ApplicationController  
  before_action :authenticate_user! do
    @user = current_user
    @company = @user.company
  end
  
  def dashboard
  end
end
