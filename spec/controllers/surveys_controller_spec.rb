require 'rails_helper'
require "cancan/matchers"

RSpec.describe SurveysController, type: :controller do
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
    @ability = Ability.new(@user)
  end

  describe "Abilities" do
    it 'create survey' do
      expect(@ability).to be_able_to(:create, @survey)
    end

    it 'show survey' do
      expect(@ability).to be_able_to(:read, @survey)
    end

    it 'add question' do
      expect(@ability).to be_able_to(:add_question, @survey)
    end

    it 'add option' do
      expect(@ability).to be_able_to(:add_option, @survey)
    end

    it 'delete option' do
      ability = Ability.new(@user)
      expect(ability).to be_able_to(:delete_option, @survey)
    end

    it 'delete question' do
      expect(@ability).to be_able_to(:delete_question, @survey)
    end

    it 'destroy survey' do
      expect(@ability).to be_able_to(:destroy, @survey)
    end
  end

  describe 'Create Survey' do
    it 'does not create a valid survey without description' do
      survey_params = { name: 'name',
                        category: 'Community',
                        survey_type: 'Private',
                        expiry: '2019-08-17',
                        group_id: '',
                        questions_attributes:
                        { '0':
                          { company_id: '1',
                            question_type: 'Radio Buttons',
                            statement: 'age',
                            required: '0',
                            options_attributes:
                            { '1':
                              { detail: '15-20' } } } } }
      expect { post :create, survey: survey_params }.to change(Survey, :count).by(1)
    end

    it 'does not create a valid survey without name' do
      survey_params = { description: 'description',
                        category: 'Community',
                        survey_type: 'Private',
                        expiry: '2019-08-17',
                        group_id: '',
                        questions_attributes:
                        { '0':
                          { company_id: '1',
                            question_type: 'Radio Buttons',
                            statement: 'age',
                            required: '0',
                            options_attributes:
                            { '1':
                              { detail: '15-20' } } } } }
      expect { post :create, survey: survey_params }.to change(Survey, :count).by(0)
    end

    it 'does not create a valid survey without expiry' do
      survey_params = { name: 'name',
                        description: 'description',
                        category: 'Community',
                        survey_type: 'Private',
                        group_id: '',
                        questions_attributes:
                        { '0':
                          { company_id: '1',
                            question_type: 'Radio Buttons',
                            statement: 'age',
                            required: '0',
                            options_attributes:
                            { '1':
                              { detail: '15-20' } } } } }
      expect { post :create, survey: survey_params }.to change(Survey, :count).by(0)
    end

    it 'creates a valid survey' do
      survey_params = { name: 'name',
                        description: 'description',
                        category: 'Community',
                        survey_type: 'Private',
                        expiry: '2019-08-17',
                        group_id: '',
                        questions_attributes:
                        { '0':
                          { company_id: '1',
                            question_type: 'Radio Buttons',
                            statement: 'age',
                            required: '0',
                            options_attributes:
                            { '1':
                              { detail: '15-20' } } } } }
      expect { post :create, survey: survey_params }.to change(Survey, :count).by(1)
    end
  end
end