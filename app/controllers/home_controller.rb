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
end