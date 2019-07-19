require 'will_paginate/array'

# get home/index
class HomeController < ApplicationController
  def index
    # UPDATE: dummy @surveys array below will be replaced by surveys object
    @surveys = ['survey1', 'survey2', 'survey3',
                'survey4', 'survey5', 'survey6',
                'survey7', 'survey8'].paginate(page: params[:page], per_page: 6)
  end

  def packages
    # UPDATE: dummy @packages array will be replaced by packages object
    @packages = ['Platinum', 'Gold', 'Silver']
  end
end
