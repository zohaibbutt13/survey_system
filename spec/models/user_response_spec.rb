require 'rails_helper'

RSpec.describe UserResponse, type: :model do
    before(:each) do
      @user = FactoryGirl.build(:user)
      @company = FactoryGirl.create(:company)
      @group = FactoryGirl.build(:group)
      @user.company = @company
      @user.role = User::ROLE[:admin]
      @user.save
      @group.users << @user
      @group.save
      @survey = FactoryGirl.build(:survey)
      @survey.user_id = @user.id
      @survey.company_id = @company.id
      @survey.group_id = @group.id
      @survey.save
      @question = FactoryGirl.build(:question)
      @question.survey_id = @survey.id
      @question.company_id = @company.id
      @question.save
      @option = FactoryGirl.build(:option)
      @option.question_id = @question.id
      @option.company_id = @company.id
      @option.save
      @user_response = FactoryGirl.build(:user_response)
      @user_response.user_id = @user.id
      @user_response.company_id = @company.id
      @user_response.survey_id = @survey.id
      @answer = FactoryGirl.build(:answer)
      @answer.question_id = @question.id
      @answer.company_id = @company.id
      @answer.user_response_id = @user_response.id
      @answer.option_id = @option.id
      @answer.save
      @user_response.answers << @answer
    end

  it 'is not valid without required question answer' do
    @answer.option_id = ' '
    expect(@user_response).to_not be_valid
  end

  it 'is valid with required question answer' do
    expect(@user_response).to be_valid
  end

  describe 'Associations' do
    it 'has many answers' do
      assc = described_class.reflect_on_association(:answers)
      expect(assc.macro).to eq :has_many
    end

    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to survey' do
      assc = described_class.reflect_on_association(:survey)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
