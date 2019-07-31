class SurveysController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @surveys = Survey.all
    @survey = Survey.new
    respond_to do |format|
      format.html
    end
  end

  def new
    @survey = Survey.new
    @question = @survey.questions.build
    respond_to do |format|
      format.html
    end
  end

  def show
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      redirect_to @survey
    else
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
      flash[:success] = 'Survey Updated!'
      redirect_to @survey
    else
      flash[:error] = 'Not Updated!'
      render action: :edit
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

  def survey_params
    params.require(:survey).permit(
      :id,
      :name,
      :description,
      :category,
      :survey_type,
      :expiry,
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
