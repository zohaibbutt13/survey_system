require 'rails_helper'

RSpec.describe CompanySetting, type: :model do
  company_setting = CompanySetting.new

  describe 'Associations' do
    it 'belongs to company' do
      assc = described_class.reflect_on_association(:company)
      expect(assc.macro).to eq :belongs_to
    end
  end

  it 'is valid with valid all checked attributes' do
    company_setting.max_questions = 50
    company_setting.supervisors_survey_permission = true
    company_setting.supervisors_settings_permission = true
    company_setting.members_settings_permission = true
    company_setting.survey_expiry_days = 5
    expect(company_setting).to be_valid
  end

  it 'is valid with valid all unchecked attributes' do
    company_setting.max_questions = 50
    company_setting.supervisors_survey_permission = false
    company_setting.supervisors_settings_permission = false
    company_setting.members_settings_permission = false
    company_setting.survey_expiry_days = 5
    expect(company_setting).to be_valid
  end

  it 'is valid with valid some checked and unchecked attributes' do
    company_setting.max_questions = 50
    company_setting.supervisors_survey_permission = false
    company_setting.supervisors_settings_permission = true
    company_setting.members_settings_permission = false
    company_setting.survey_expiry_days = 5
    expect(company_setting).to be_valid
  end

  it 'is not valid with max_question more than 500' do
    company_setting.max_questions = 501
    expect(company_setting).to_not be_valid
  end
end