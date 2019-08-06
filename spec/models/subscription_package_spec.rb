require 'rails_helper'

RSpec.describe SubscriptionPackage, type: :model do
  subscription_package = SubscriptionPackage.new

  describe 'Associations' do
    it 'has many companies' do
      assc = described_class.reflect_on_association(:companies)
      expect(assc.macro).to eq :has_many
    end
  end

  it 'is valid with these type of attributes' do
    subscription_package.subscription_package_name = 'Gold'
    subscription_package.max_supervisors = 20
    subscription_package.max_members = 300   
    expect(subscription_package).to be_valid
  end
end