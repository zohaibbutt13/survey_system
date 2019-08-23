class CompaniesController < ApplicationController
  before_action :authenticate_user!

  before_action only: [:filter, :display_surveys] do
    @surveys = Survey.all
  end

  def dashboard
    add_breadcrumb "Dashboard", dashboard_company_path(@current_company)
    @activities = @current_company.activities.get_user_activities(current_user)
    @surveys_stats = [@current_company.surveys.expired_surveys.count,
                      @current_company.surveys.active_surveys.count]
    @latest_surveys_labels = @current_company.surveys.latest_surveys.limit(3).pluck(:name)
    @latest_surveys_responses_count = @current_company.surveys.latest_surveys_responses(3)
    respond_to do |format|
      format.html
    end
  end

  def subscription_packages
    add_breadcrumb "Subscription Packages", subscription_packages_company_path(@current_company)
    @subscription_packages = SubscriptionPackage.first(3)
    respond_to do |format|
      format.html
    end
  end

  def update_subscription_package
    @current_company.subscription_package_id = params[:id]
    if @current_company.save
      respond_to do |format|@surveys = Survey.all
        flash[:notice] = I18n.t 'package.subscription_package_update_label'  
        format.html { redirect_to dashboard_company_path }
      end
    else
      flash[:error] = @current_company.errors.full_messages
      format.html { redirect_to subscription_packages_company_path(current_user) }
    end
  end

  def filter
    @surveys = Company.filter_surveys(params[:filters][:name], params[:filters][:expired_before], params[:filters][:survey_type], params[:filters][:created_on], params[:filters][:created_by_id])
    respond_to do |format|
      format.js
    end
  end

  def display_surveys
    @employees = User.all
    add_breadcrumb "Surveys", display_surveys_company_path(@current_company)
    respond_to do |format|
      format.html
      format.js
    end
  end
end