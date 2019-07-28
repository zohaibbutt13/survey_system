class SurveysController < ApplicationController
  
  # GET  shows all the surveys of a company
  def index
    @surveys = Survey.all
    respond_to do |format|
      format.html
    end
  end

  # GET builds a new survey object
  def new
    @survey = Survey.new
    @question = @survey.questions.build
    @option = @question.options.build
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
    @survey = Survey.new(survey_params)
    # @survey.questions.first.user_id = current_user.user_id
    if Survey.save?(@survey)
      flash[:notice] = 'Survey Created'
      redirect_to @survey
    else
      flash[:error] = 'Survey did not create'
      render action: :new
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

  # whitelists parameters
  def survey_params
    params.require(:survey).permit(
      :name,
      :description,
      :category,
      :survey_type,
      :expiry,
      questions_attributes: [:statement, :question_type,
      options_attributes: [:detail]]
    )
  end
end
