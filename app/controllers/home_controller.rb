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

  # get home/packages
  def packages
    @packages = SubscriptionPackage.get_packages
    respond_to do |format|
      format.html
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

  def sign_in_redirect
    user = User.unscoped.find_by_email(params[:email])
    respond_to do |format|
      if user.present?
        format.html { redirect_to subdomain: user.company.subdomain, controller: 'users/sessions', action: 'new' }
      else
        flash[:error] = I18n.t 'user_not_found'
        format.html { render :sign_in }
      end
    end
  end
end