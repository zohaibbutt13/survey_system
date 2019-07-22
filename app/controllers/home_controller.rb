require 'will_paginate/array'

# get 'home/index'
class HomeController < ApplicationController
  def index
    @surveys = Survey.get_public_surveys.paginate(page: params[:page], per_page: 6)
  end

  def packages
    @packages = SubscriptionPackage.get_packages
  end
end
