class SurveysController < ApplicationController
  
  def index
    @surveys = Survey.all
  end

  def new
    @survey = Survey.new
    @question = @survey.questions.build
    @option = @question.options.build 
  end

  def show
    @survey = Survey.find(params[:id])
  end

  def create
    @survey = Survey.new(survey_params)
    # @survey.questions.first.user_id = current_user.user_id
    if @survey.save
      flash[:success] = 'Survey Created'
      redirect_to @survey
    else
      render action: :new
    end
  end

  def add_question
    respond_to do |format|
      format.js
    end
  end

  def add_option
    respond_to do |format|
      format.js
    end
  end

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
