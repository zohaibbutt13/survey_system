class CompaniesController < ApplicationController
  before_action :authenticate_user!

  before_action only: [:filter, :display_surveys] do
    @surveys = Survey.all
  end

  def dashboard
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
    add_breadcrumb "Subscription Packages", subscription_packages_company_path
    @subscription_packages = SubscriptionPackage.first(3)
    respond_to do |format|
      format.html
    end
  end

  def update_subscription_package
    @current_company.subscription_package_id = params[:id]
    if @current_company.save
      respond_to do |format|
        flash[:notice] = I18n.t(:subscription_package_update_label)  
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
    @surveys = @surveys.where('expiry > ?', params[:filters][:expired_after]) unless params[:filters][:expired_after].blank?
    @surveys = @surveys.where('created_at > ?', params[:filters][:created_after]) unless params[:filters][:created_after].blank?
    @surveys = @surveys.where('created_at < ?', params[:filters][:created_before]) unless params[:filters][:created_before].blank?

    respond_to do |format|
      format.js
    end
  end

  # get home/display_surveys
  def display_surveys
    if params[:filter_by] == 'expiry'
      @surveys = @surveys.expired_surveys
    elsif params[:filter_by] == 'active'
      @surveys = @surveys.active_surveys
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end