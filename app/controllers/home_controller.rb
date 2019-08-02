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
      @surveys = Survey.expired_surveys
    elsif params[:filter_by] == 'active'
      @surveys = Survey.active_surveys
    else
      @surveys = Survey.all
    end
    respond_to do |format|
      format.html
    end
  end

  def main_charts
    @surveys_stats = [Survey.expired_surveys.count, Survey.active_surveys.count]
    @surveys_stats_labels = ['Expired', 'Active']
    @latest_surveys_labels = Survey.latest_surveys_names(3)
    @latest_surveys_responses_count = Survey.latest_surveys_responses(3)
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
