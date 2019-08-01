require 'rails_helper'

RSpec.describe Company, type: :model do
  company = Company.new

  describe 'Associations' do
    it 'belongs to subscription_package' do
      assc = described_class.reflect_on_association(:subscription_package)
      expect(assc.macro).to eq :belongs_to
    end

    it 'has many groups' do
      assc = described_class.reflect_on_association(:groups)
      expect(assc.macro).to eq :has_many
    end

    it 'has many users' do
      assc = described_class.reflect_on_association(:users)
      expect(assc.macro).to eq :has_many
    end

    it 'has many surveys' do
      assc = described_class.reflect_on_association(:surveys)
      expect(assc.macro).to eq :has_many
    end

    it 'has many questions' do
      assc = described_class.reflect_on_association(:questions)
      expect(assc.macro).to eq :has_many
    end

    it 'has many options' do
      assc = described_class.reflect_on_association(:options)
      expect(assc.macro).to eq :has_many
    end

    it 'has many responses' do
      assc = described_class.reflect_on_association(:responses)
      expect(assc.macro).to eq :has_many
    end

    it 'has many user_settings' do
      assc = described_class.reflect_on_association(:user_settings)
      expect(assc.macro).to eq :has_many
    end

    it 'has one company_setting' do
      assc = described_class.reflect_on_association(:company_setting)
      expect(assc.macro).to eq :has_one
    end
  end

  it 'is valid with these kind of attributes' do
    company.name = 'abc'
    company.status = 'active'
    company.cancelled_on = DateTime.now
    expect(company).to be_valid
  end

  it 'is not valid without company name' do
    company.name = nil
    expect(company).to_not be_valid
  end  
end