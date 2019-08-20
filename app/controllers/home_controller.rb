class HomeController < ApplicationController

  before_action do
    if user_signed_in?
      redirect_to dashboard_company_path(@current_company)
    end
  end

  # get home/index
  def index
    @surveys = Survey.get_public_surveys(params[:page], PER_PAGE_SURVEYS)
    @categories = Survey::CATEGORIES
    respond_to do |format|
      format.html
    end
  end

  def filter_category
    @categories = Survey::CATEGORIES
    @surveys = Survey.get_public_surveys(params[:page], PER_PAGE_SURVEYS, params[:filter_by])
    respond_to do |format|
      format.js
    end
  end

  def company_redirect
    @companies = Company.unscoped.all
  end

  def sign_in
    respond_to do |format|
      format.html
    end
  end

  def companies_list
    respond_to do |format|
      if User.unscoped.find_by(email: params[:email]).nil?
        format.html { redirect_to sign_in_home_index_path }
      else
        format.html {
          @companies = Company.joins('INNER JOIN users on users.company_id = companies.id').where("users.email = ?", params[:email])
          @email = params[:email]
        }
      end
    end
  end
end