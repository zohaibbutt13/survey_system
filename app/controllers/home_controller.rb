class HomeController < ApplicationController
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
end
