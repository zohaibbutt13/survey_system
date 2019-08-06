class HomeController < ApplicationController
  # get home/index
  def index
    @surveys = Survey.get_public_surveys(params[:page], PER_PAGE_SURVEYS)
    respond_to do |format|
      format.html
    end
  end

  # get home/packages
  def packages
    @packages = SubscriptionPackage.get_packages
    respond_to do |format|
      format.html
    end
  end

  # get home/display_surveys
  def display_surveys
    if params[:filter_by] == 'expiry'
      @surveys = @current_company.surveys.expired_surveys
    elsif params[:filter_by] == 'active'
      @surveys = @current_company.surveys.active_surveys
    else
      @surveys = @current_company.surveys
    end
    respond_to do |format|
      format.html
    end
  end

  def main_charts
    @surveys_stats = [@current_company.surveys.expired_surveys.count,
                      @current_company.surveys.active_surveys.count]
    @surveys_stats_labels = ['Expired', 'Active']
    @latest_surveys_labels = @current_company.surveys.latest_surveys.limit(3).pluck(:name)
    @latest_surveys_responses_count = @current_company.surveys.latest_surveys_responses(3)
    respond_to do |format|
      format.html
    end
  end

  # get home/:id/survey_charts
  def survey_charts
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
end
