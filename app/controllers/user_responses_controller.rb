class UserResponsesController < ApplicationController
  # load_and_authorize_resource :survey
  # load_and_authorize_resource :user_response, through: :survey
  # GET list all the responses of a survey
  def index
    @survey = Survey.find(params[:survey_id])
    @user_responses = @survey.user_responses
    @response_per_page = UserResponse.response_per_page(@user_responses, params[:page], 1)
    respond_to do |format|
      format.js
    end
  end

  # GET directs to the new action of user_response
  def new
    @survey = Survey.find(params[:survey_id])
    @user_response = UserResponse.new
    @answer = @user_response.answers.build
  end

  # GET shows the response with given id
  def show
    @survey = Survey.find(params[:survey_id])
    @user_response = @survey.user_responses.find(params[:id])
  end

  # POST creates a new user_response
  def create
    @survey = Survey.find(params[:survey_id])
    @user_response = UserResponse.new(response_params)
    if @user_response.save
      flash[:notice] = 'Saved'
      redirect_to survey_user_response_path(@survey, @user_response)
    else
      flash[:error] = 'Incomplete Information'
      render action: :new
    end
  end

  # set response params
  def set_response_params
    manipulate_answers_attributes = {}
    index_new_hash = params[:user_response][:answers_attributes].length
    params[:user_response][:answers_attributes].each_with_index do |(_key, value), _index|
      if value['option_id'].class == Array
        option_array = value['option_id']
        value['option_id'] = option_array.first
        option_array[1..-1].each do |option|
          if option_array.length == 1
            value['option_id'] = option
          else
            manipulate_answers_attributes["#{index_new_hash}"] = {detail: "#{value['detail']}", question_id: "#{value['question_id']}", option_id: "#{option}" }
            index_new_hash += 1
          end
        end
      end
    end
    params[:user_response][:answers_attributes] = params[:user_response][:answers_attributes].merge manipulate_answers_attributes
  end

  # whitelists parameters
  def response_params
    set_response_params
    params.require(:user_response).permit(
      :id,
      :email,
      :survey_id,
      answers_attributes: [:id, :detail, :question_id, :option_id, option_id: []]
    )
  end
end
