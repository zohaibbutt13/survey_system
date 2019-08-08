class SurveysController < ApplicationController
  load_and_authorize_resource
  before_action :set_group, only: [:new, :edit, :create, :update]

  def set_group
    @groups = @current_company.groups.all
  end
  
  # GET  shows all the surveys of a company
  def index
    respond_to do |format|
      format.html
    end
  end

  # GET builds a new survey object
  def new
    @question = @survey.questions.build 
    respond_to do |format|
      format.html
    end
  end

  # GET displays survey based on the given id
  def show
    respond_to do |format|
      format.html
    end
  end

  # POST creates a new survey
  def create
    if @survey.save
      flash[:notice] = 'Survey Created'
      redirect_to @survey
    else
      flash[:error] = 'Incomplete information'
      render action: :new
    
    end
  end

  # edit form for a survey with given id
  def edit
    respond_to do |format|
      format.html
    end
  end

  # updates the survey
  def update
    if @survey.update(survey_params)
      flash[:notice] = 'Survey Updated!'
      redirect_to @survey
    else
      flash[:error] = 'Not Updated!'
      render action: :edit
    end
  end

  # GET adds a new question to the surveycompany_id: user.company_id
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

  # GET deletes an option
  def delete_option
    respond_to do |format|
      format.js
    end
  end

  # GET deletes a question
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
      questions_attributes: [:id, :statement, :question_type, :company_id,
      options_attributes: [:id, :detail]]
    )
  end

  # deletes survey
  def destroy
    @survey.destroy
    redirect_to surveys_path, notice: 'Delete success'
  end
end
