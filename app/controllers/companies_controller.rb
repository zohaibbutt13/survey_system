class CompaniesController < ApplicationController
  before_action :authenticate_user!

  before_action only: [:filter, :display_surveys] do
    @surveys = Survey.all
  end

  def dashboard
  end

  def filter
    @surveys = @surveys.where('name LIKE ?', "%#{params[:filters][:name]}%") unless params[:filters][:name].blank?
    @surveys = @surveys.where('expiry < ?', params[:filters][:expired_before]) unless params[:filters][:expired_before].blank? 
    @surveys = @surveys.where('survey_type = ?', params[:filters][:survey_type]) unless params[:filters][:survey_type].blank? 
    respond_to do |format|
      format.js
    end
  end

  # get home/display_surveys
  def display_surveys
    if params[:filter_by] == 'expiry'
      @surveys = @surveys.expired_surveys
    elsif params[:filter_by] == 'active'
      @surveys = @surveys.active_surveys
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end