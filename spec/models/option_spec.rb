require 'rails_helper'

RSpec.describe Option, type: :model do
  option = Option.new

  it 'is valid with valid detail' do
    option.detail = '1'
    option.question_id = 1
    expect(option).to be_valid
  end

  it 'is not valid without a detail' do
    option.detail = nil
    expect(option).to_not be_valid
  end

  describe 'Associations' do
    it 'belongs to company' do
      assc = described_class.reflect_on_association(:company)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to question' do
      assc = described_class.reflect_on_association(:question)
      expect(assc.macro).to eq :belongs_to
    end
  end
end