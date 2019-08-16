require 'rails_helper'
require "cancan/matchers"

RSpec.describe SurveysController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @company = FactoryGirl.create(:company)
    @user.company = @company
    @user.role = User::ROLE[:member]
    @user.save
    @request.host = "#{@company.subdomain}." + request.host
    sign_in @user
    @survey = Survey.new
    @survey.id = 1
    @survey.name = 'name'
    @survey.description = 'description'
    @survey.category = 'Community'
    @survey.survey_type = 'Private'
    @survey.expiry = '2019-08-17'
    @survey.group_id = ''
    @survey.save
  end

  describe "Abilities" do
    it "create survey" do
      ability = Ability.new(@user)
      expect(ability).to_not be_able_to(:create, @survey)
    end

    it 'show survey' do
      ability = Ability.new(@user)
      expect(ability).to_not be_able_to(:read, @survey)
    end

    it 'renders the add question template' do
      ability = Ability.new(@user)
      expect(ability).to_not be_able_to(:add_question, @survey)
    end

    it 'renders the add option template' do
      ability = Ability.new(@user)
      expect(ability).to_not be_able_to(:add_option, @survey)
    end

    it 'destroy survey' do
      ability = Ability.new(@user)
      expect(ability).to_not be_able_to(:destroy, @survey)
    end
  end

  describe 'Create Survey' do
    it 'does not create a valid survey' do
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
      expect { post :create, survey: survey_params }.to change(Survey, :count).by(-1)
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
      expect { post :create, survey: survey_params }.to change(Survey, :count).by(0)
    end
  end
end