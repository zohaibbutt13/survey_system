require 'will_paginate/array'

class HomeController < ApplicationController
  # get home/index
  def index
    @surveys = Survey.get_public_surveys(params[:page], PER_PAGE_SURVEYS)
  end

  # get home/packages
  def packages
    @packages = SubscriptionPackage.get_packages
  end

  # get home/display_surveys
  def display_surveys
    @surveys = Survey.all
  end

  # get home/display_expired_surveys
  def display_expired_surveys
    @surveys = Survey.get_expired_surveys
    render 'display_surveys'
  end

  # get home/display_active_surveys
  def display_active_surveys
    @surveys = Survey.get_active_surveys
    render 'display_surveys'
  end
end
