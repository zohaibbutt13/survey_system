require 'rails_helper'
require "cancan/matchers"

RSpec.describe UserResponsesController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @company = FactoryGirl.create(:company)
    @user.company = @company
    @user.role = User::ROLE[:admin]
    @user.save
    @request.host = "#{@company.subdomain}." + request.host
    sign_in @user
    @survey = FactoryGirl.create(:survey)
    @survey.user_id = @user.id
    @survey.company_id = @company.id
    @survey.save
    @my_response = FactoryGirl.create(:user_response)
    @my_response.user_id = @user.id
    @my_response.company_id = @company.id
    @my_response.survey_id = @survey.id
    @my_response.save
    @ability = Ability.new(@user)
  end

  describe "Abilities" do
    it 'create response' do
      expect(@ability).to be_able_to(:create, @my_response)
    end

    it 'show response' do
      expect(@ability).to be_able_to(:read, @my_response)
    end

    it 'index response' do
      expect(@ability).to be_able_to(:read, @my_response)
    end
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
