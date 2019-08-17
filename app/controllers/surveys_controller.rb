class SurveysController < ApplicationController
  load_and_authorize_resource
  before_action :set_group, only: [:new, :edit, :create, :update]
  before_action :breadcrumb_path_add

  def set_group
    @groups = @current_company.groups.all
  end
  
  # GET  /surveys
  def index
    @surveys = Survey.all
    @survey = Survey.new
    respond_to do |format|
      format.html
    end
  end

  # GET surveys/new
  def new
    add_breadcrumb "<a>New Survey</a>".html_safe, new_survey_path
    @survey = Survey.new
    @question = @survey.questions.build 
    respond_to do |format|
      format.html
    end
  end

  # GET survey/:id
  def show
    add_breadcrumb "<a>Your Survey</a>".html_safe, survey_path
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # POST /surveys
  def create
    @survey.user_id = @current_user.id
    if @survey.save
      flash[:notice] = I18n.t 'surveys.survey_create_success'
      redirect_to @survey
    else
      flash[:error] = @survey.errors.full_messages
      render action: :new
    
    end
  end

  # edit surveys/:id/edit
  def edit
    add_breadcrumb "<a>Edit Survey</a>".html_safe, edit_survey_path
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # patch surveys/:id
  def update
    if @survey.update(survey_params)
      flash[:notice] = I18n.t 'surveys.survey_update_success'
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
      flash[:notice] = I18n.t 'surveys.survey_destroy_success'
      redirect_to display_surveys_company_path(@current_company)
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

  def breadcrumb_path_add
    add_breadcrumb "<b>Surveys</b>".html_safe, display_surveys_company_path(@current_company)
  end
end
