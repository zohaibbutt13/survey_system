class CompaniesController < ApplicationController
  before_action :authenticate_user!
  #   @user = current_user
  #   @company = @user.company
  # end
  # before_action :authenticate_admin!, only: [:employees, :groups]

  def dashboard
  end

  def company_settings
  end

  def filter
    @surveys = Survey.all

    @surveys = @surveys.where('name LIKE ?', "%#{params[:filters][:name]}%") unless params[:filters][:name].blank?

    @surveys = @surveys.where('expiry < ?', params[:filters][:expired_before]) unless params[:filters][:expired_before].blank?

    @surveys = @surveys.where('expiry > ?', params[:filters][:expired_after]) unless params[:filters][:expired_after].blank?

    respond_to do |format|
      format.js
    end
  end

  # get home/display_surveys
  def display_surveys
    if params[:filter_by] == 'expiry'
      @surveys = Survey.get_expired_surveys
    elsif params[:filter_by] == 'active'
      @surveys = Survey.get_active_surveys
    else
      @surveys = Survey.all
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
