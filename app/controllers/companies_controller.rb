class CompaniesController < ApplicationController
  before_action :authenticate_user!

  before_action only: [:filter, :display_surveys] do
    @surveys = Survey.all
  end

  def dashboard
    @activities = @current_company.activities.get_user_activities(current_user)
    @surveys_stats = [@current_company.surveys.expired_surveys.count,
                      @current_company.surveys.active_surveys.count]
    @latest_surveys_labels = @current_company.surveys.latest_surveys.limit(3).pluck(:name)
    @latest_surveys_responses_count = @current_company.surveys.latest_surveys_responses(3)
    respond_to do |format|
      format.html
    end
  end

  def filter
    @surveys = @surveys.where('name LIKE ?', "%#{params[:filters][:name]}%") unless params[:filters][:name].blank?
    @surveys = @surveys.where('expiry < ?', params[:filters][:expired_before]) unless params[:filters][:expired_before].blank? 
    @surveys = @surveys.where('survey_type = ?', params[:filters][:survey_type]) unless params[:filters][:survey_type].blank?
    @surveys = @surveys.where('Date(created_at) = ?', params[:filters][:created_on]) unless params[:filters][:created_on].blank? 
    @surveys = @surveys.where('user_id = ?', params[:filters][:created_by_id]) unless params[:filters][:created_by_id].blank?  
    respond_to do |format|
      format.js
    end
  end

  # get home/display_surveys
  def display_surveys
    # if params[:filter_by] == 'expiry'
    #   @surveys = @surveys.expired_surveys
    # elsif params[:filter_by] == 'active'
    #   @surveys = @surveys.active_surveys
    # end
    @employees = User.all
    respond_to do |format|
      format.html
      format.js
    end
  end
end