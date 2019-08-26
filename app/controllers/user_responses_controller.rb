class UserResponsesController < ApplicationController
  load_and_authorize_resource :survey
  load_and_authorize_resource :user_response, through: :survey
  # get surveys/:id/user_responses
  def index
    @response_per_page = @user_responses.paginate(page: params[:page], per_page: RESPONSE_PER_PAGE)
    respond_to do |format|
      format.js
    end
  end

  # get surveys/:id/new
  def new
    @answer = @user_response.answers.build
  end

  # get surveys/:survey_id/user_response/:id
  def show
  end

  # post surveys/:survey_id/user_responses      
  def create
    if user_signed_in?
      @user_response.user_id = current_user.id
      @user_response.company_id = current_user.company_id
      @user_response.email = current_user.email
    end
    if @user_response.save
      flash[:notice] = 'Saved'
      redirect_to survey_user_response_path(@survey, @user_response)
    else
      flash[:error] = @user_response.errors.full_messages
      redirect_to new_survey_user_response_path
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
  def user_response_params
    set_response_params
    params.require(:user_response).permit(
      :id,
      :email,
      :survey_id,
      answers_attributes: [:id, :detail, :question_id, :option_id, option_id: []]
    )
  end
end