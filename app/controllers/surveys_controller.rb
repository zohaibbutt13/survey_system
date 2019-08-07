class SurveysController < ApplicationController
  
  before_action :set_groups, only: [:new, :edit, :update, :create]

  def set_groups
    @groups = @current_company.groups
  end

  # GET  shows all the surveys of a company
  def index
    add_breadcrumb "Surveys", surveys_path
    @surveys = Survey.all
    @survey = Survey.new
    respond_to do |format|
      format.html
    end
  end

  # GET builds a new survey object
  def new
    add_breadcrumb "Surveys", surveys_path
    add_breadcrumb "New Survey", new_survey_path
    @survey = Survey.new
    @question = @survey.questions.build 
    respond_to do |format|
      format.html
    end
  end

  # GET displays survey based on the given id
  def show
    add_breadcrumb "Surveys", surveys_path
    add_breadcrumb "Your Survey", survey_path
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # POST creates a new survey
  def create
    # @survey.questions.first.user_id = current_user.user_id
    @survey = Survey.new(survey_params)
    if @survey.save
      flash[:notice] = 'Survey Created'
      redirect_to @survey
    else
      flash[:error] = 'Incomplete information'
      render action: :new
    
    end
  end

  def edit
    add_breadcrumb "Surveys", surveys_path
    add_breadcrumb "Edit Survey", edit_survey_path
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def update
    @survey = Survey.find(params[:id])
    if @survey.update(survey_params)
      flash[:notice] = 'Survey Updated!'
      redirect_to @survey
    else
      flash[:error] = 'Not Updated!'
      render action: :edit
    end
  end

  # GET adds a new question to the survey
  def add_question
    respond_to do |format|
      format.js
    end
  end

  # GET adds a new option
  def add_option
    respond_to do |format|
      format.js
    end
  end

  def delete_option
    respond_to do |format|
      format.js
    end
  end

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
      questions_attributes: [:id, :statement, :question_type,
      options_attributes: [:id, :detail]]
    )
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    redirect_to surveys_path, notice: 'Delete success'
  end
end
