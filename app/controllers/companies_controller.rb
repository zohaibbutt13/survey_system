class CompaniesController < ApplicationController
  before_action :authenticate_user!

  before_action only: [:filter, :display_surveys] do
    @surveys = Survey.all
  end

  def dashboard
    add_breadcrumb "<a>Dashboard</a>".html_safe, dashboard_company_path
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
    add_breadcrumb "<a>Subscription Packages</a>".html_safe, subscription_packages_company_path
    @subscription_packages = SubscriptionPackage.first(3)
    respond_to do |format|
      format.html
    end
  end

  def update_subscription_package
    @current_company.subscription_package_id = params[:id]
    if @current_company.save
      respond_to do |format|
        flash[:notice] = I18n.t 'package.subscription_package_update_label'  
        format.html { redirect_to dashboard_company_path }
      end
    else
      flash[:error] = @current_company.errors.full_messages
      format.html { redirect_to subscription_packages_company_path(current_user) }
    end
  end

  def filter
    @surveys = @surveys.where('name LIKE ?', "%#{params[:filters][:name]}%") unless params[:filters][:name].blank?
    @surveys = @surveys.where('expiry < ?', params[:filters][:expired_before]) unless params[:filters][:expired_before].blank? 
    @surveys = @surveys.where('survey_type = ?', params[:filters][:survey_type]) unless params[:filters][:survey_type].blank?
    @surveys = @surveys.where('Date(created_at) = ?', params[:filters][:created_on]) unless params[:filters][:created_on].blank? 
    @surveys = @surveys.where('user_id = ?', params[:filters][:created_by_id]) unless params[:filters][:created_by_id].blank?
    @surveys = @surveys.where('Date(created_at) > ?', params[:filters][:created_between_st]) unless params[:filters][:created_between_st].blank?
    @surveys = @surveys.where('Date(created_at) < ?', params[:filters][:created_between_end]) unless params[:filters][:created_between_end].blank?    
    
    respond_to do |format|
      format.js
    end
  end

  #move to surveys
  # get home/display_surveys
  def display_surveys
    @employees = User.all
    add_breadcrumb "<a>Surveys</a>".html_safe, display_surveys_company_path(@current_company)
    respond_to do |format|
      format.html
      format.js
    end
  end
end