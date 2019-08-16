require 'rails_helper'

RSpec.describe UserResponsesController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @company = FactoryGirl.create(:company)
    @user.company = @company
    @user.role = User::ROLE[:admin]
    @user.save
    @request.host = "#{@company.subdomain}." + request.host
    sign_in @user
    @survey = Survey.new
    @survey.id = 10
    @survey.name = 'name'
    @survey.description = 'description'
    @survey.category = 'Community'
    @survey.survey_type = 'Private'
    @survey.expiry = '2019-08-17'
    @survey.group_id = ''
    @survey.save
  end

  it 'renders the index template' do
    get :index, survey_id: @survey.id, use_route: :surveys
    expect(response).to have_http_status(:success)
  end

  it 'renders the new template' do
    get :new, survey_id: @survey.id
    expect(response).to render_template('new')
  end

  it 'renders the show template' do
    get :show, survey_id: @survey.id, use_route: :surveys
    expect(response).to have_http_status(:success)
  end

  describe 'Create_Survey' do
    it 'creates a valid user_response' do
      user_response_params = { survey_id: '11',
                                answers_attributes:
                              { "0":
                                { question_id: '22',
                                  option_id: '32',
                                  detail: '21-25' } } }
    end
  end
end
