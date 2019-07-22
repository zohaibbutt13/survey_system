require 'will_paginate/array'

# get 'activity/index'
class ActivityController < ApplicationController
  def index
    # if @current_user.role == 'admin'
    # @activities = Activity.get_company_activity(@current_user.company_id)
    # else
     @activities = Activity.get_user_activity(3) # UPDATE: Replace 3 -> @current_user.id
    # end
  end
end
