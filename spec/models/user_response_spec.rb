require 'rails_helper'

RSpec.describe UserResponse, type: :model do
  user_response = UserResponse.new

  it 'is valid with valid attributes' do
    user_response.user_id = 1
    user_response.survey_id = 66
    user_response.email = 'abc@gmail.com'
    expect(user_response).to be_valid
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
