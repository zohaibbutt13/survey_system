class ActivityController < ApplicationController
  # get activity/index
  def index
    @activities = @current_company.activities.get_user_activities(current_user)
    respond_to do |format|
      format.html
    end
  end
end
