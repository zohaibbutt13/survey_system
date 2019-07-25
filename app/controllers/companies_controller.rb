class CompaniesController < ApplicationController
  # before_action :authenticate_user! do
  #   @user = current_user
  #   @company = @user.company
  # end
  # before_action :authenticate_admin!, only: [:employees, :groups]

  def dashboard
  end

  def company_settings
  end
end
