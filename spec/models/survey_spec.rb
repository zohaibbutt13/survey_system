require 'rails_helper'

RSpec.describe Survey, type: :model do
  survey = Survey.new

  it 'is valid with valid attributes' do
    survey.name = 'First'
    survey.description = 'This is the first survey'
    survey.category = 'Developers'
    survey.image = 'nil'
    survey.survey_type = 'Private'
    survey.expiry = DateTime.now + 1.week
    survey.user_id = 1
    expect(survey).to be_valid
  end

  it 'is not valid without a name' do
    survey.name = nil
    expect(survey).to_not be_valid
  end

  it 'is not valid without a description' do
    survey.description = nil
    expect(survey).to_not be_valid
  end

  describe 'Associations' do
    it 'has many questions' do
      assc = described_class.reflect_on_association(:questions)
      expect(assc.macro).to eq :has_many
    end

    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to company' do
      assc = described_class.reflect_on_association(:company)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
