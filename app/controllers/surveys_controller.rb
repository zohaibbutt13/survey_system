class SurveysController < ApplicationController
  
  before_action do
    @groups = Group.all
  end
  
  # GET  shows all the surveys of a company
  def index
    @surveys = Survey.all
    @survey = Survey.new
    respond_to do |format|
      format.html
    end
  end

  # GET builds a new survey object
  def new
    @survey = Survey.new
    @question = @survey.questions.build 
    respond_to do |format|
      format.html
    end
  end

  # GET displays survey based on the given id
  def show
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  # POST creates a new survey
  def create
    @survey = current_user.surveys.new(survey_params)
    @survey.company_id = current_user
    if @survey.save
      flash[:notice] = 'Survey Created'
      redirect_to @survey
    else
      flash[:error] = 'Incomplete information'
      render action: :new
    
    end
  end

  def edit
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
      questions_attributes: [:id, :statement, :question_type, :required,
      options_attributes: [:id, :detail]]
    )
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    redirect_to surveys_path, notice: 'Delete success'
  end
end
