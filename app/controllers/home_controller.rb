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
end
