require 'will_paginate/array'

class ActivityController < ApplicationController
  # get activity/index
  def index
    @activities = Activity.get_user_activities(@current_user)
  end
end