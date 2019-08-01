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
      @surveys = Survey.get_expired_surveys
    elsif params[:filter_by] == 'active'
      @surveys = Survey.get_active_surveys
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
  end

  # get home/:id/survey_charts
  def survey_charts
    @survey = Survey.find(params[:id])
  end
end
