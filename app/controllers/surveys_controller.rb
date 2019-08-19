class SurveysController < ApplicationController
  protect_from_forgery except: [:add_question, :add_option]
  load_and_authorize_resource
  before_action :set_group, only: [:new, :edit, :create, :update]

  def set_group
    @groups = @current_company.groups.all
  end
  
  # GET  /surveys
  def index
    add_breadcrumb "Surveys", display_surveys_company_path(@current_company)
    @surveys = Survey.all
    @survey = Survey.new
    respond_to do |format|
      format.html
    end
  end

  # GET surveys/new
  def new
    add_breadcrumb "Surveys", display_surveys_company_path(@current_company)
    add_breadcrumb "New Survey", new_survey_path
    @survey = Survey.new
    @question = @survey.questions.build 
    respond_to do |format|
      format.html
    end
  end

  # GET survey/:id
  def show
    add_breadcrumb "Surveys", display_surveys_company_path(@current_company)
    add_breadcrumb "Your Survey", survey_path
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # POST /surveys
  def create
    @survey.user_id = @current_user.id
    if @survey.save
      flash[:notice] = 'Survey Created'
      redirect_to @survey
    else
      flash[:error] = @survey.errors.full_messages
      render action: :new
    
    end
  end

  # edit surveys/:id/edit
  def edit
    add_breadcrumb "Surveys", display_surveys_company_path(@current_company)
    add_breadcrumb "Edit Survey", edit_survey_path
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # patch surveys/:id
  def update
    if @survey.update(survey_params)
      flash[:notice] = 'Survey Updated!'
      redirect_to @survey
    else
      flash[:error] = @survey.errors.full_messages
      render action: :edit
    end
  end

  # GET surveys/add_question
  def add_question
    respond_to do |format|
      format.js
    end
  end

  # GET surveys/add_option
  def add_option
    respond_to do |format|
      format.js
    end
  end

  # GET surveys/delete_option
  def delete_option
    respond_to do |format|
      format.js
    end
  end

  # GET surveys/delete_question
  def delete_question
    respond_to do |format|
      format.js
    end
  end

  # whitelists parameters
  def survey_params
    params.require(:survey).permit(
      :id,
      :name,
      :description,
      :category,
      :survey_type,
      :expiry,
      :group_id,
      questions_attributes: [:id, :statement, :question_type, :required, :company_id,
      options_attributes: [:id, :detail, :company_id]]
    )
  end

  # delete surveys/:id
  def destroy
    if @survey.destroy
      redirect_to display_surveys_company_path(@current_company), notice: 'Delete success'
    else
      flash[:error] = @survey.errors.full_messages
      render action: :show
    end
  end

  # get survey/:id/survey_charts
  def survey_charts
    @survey.questions.includes(:answers)
    respond_to do |format|
      format.html
    end
  end
end
