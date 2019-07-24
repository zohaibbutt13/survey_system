require 'will_paginate/array'


class HomeController < ApplicationController
  # get home/index
  def index
    @surveys = Survey.get_public_surveys.paginate(page: params[:page], per_page: 6)
  end

  # get home/packages
  def packages
    @packages = SubscriptionPackage.get_packages
  end
end
