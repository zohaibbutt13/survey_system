require 'rails_helper'

RSpec.describe UserSetting, type: :model do
  user_setting = UserSetting.new

  describe 'Associations' do
    it 'belongs to user' do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to company' do
      assc = described_class.reflect_on_association(:company)
      expect(assc.macro).to eq :belongs_to
    end
  end

  it 'is valid with valid all checked attributes' do
    user_setting.emails_subscription = true
    user_setting.show_graphs = true
    user_setting.show_history = true
    expect(user_setting).to be_valid
  end

  it 'is valid with valid all unchecked attributes' do
    user_setting.emails_subscription = false
    user_setting.show_graphs = false
    user_setting.show_history = false
    expect(user_setting).to be_valid
  end

  it 'is valid with valid some checked and unchecked attributes' do
    user_setting.emails_subscription = true
    user_setting.show_graphs = false
    user_setting.show_history = true
    expect(user_setting).to be_valid
  end
end