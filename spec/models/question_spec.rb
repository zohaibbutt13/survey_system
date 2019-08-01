require 'rails_helper'

RSpec.describe Question, type: :model do
  question = Question.new

  it 'is valid with valid attributes' do
    question.statement = 'What is your name'
    question.question_type = 'Comment Box'
    question.survey_id = 1
    expect(question).to be_valid
  end

  it 'is not valid without question type' do
    question.question_type = nil
    expect(question).to_not be_valid
  end

  it 'is not valid without a statement' do
    question.statement = nil
    expect(question).to_not be_valid
  end

  describe 'Associations' do
    it 'has many options' do
      assc = described_class.reflect_on_association(:options)
      expect(assc.macro).to eq :has_many
    end

    it 'has many responses' do
      assc = described_class.reflect_on_association(:responses)
      expect(assc.macro).to eq :has_many
    end

    it 'belongs to company' do
      assc = described_class.reflect_on_association(:company)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to survey' do
      assc = described_class.reflect_on_association(:survey)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
