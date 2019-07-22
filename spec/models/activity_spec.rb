# spec/models/review_spec.rb
require 'rails_helper'

RSpec.describe Activity, :type => :model do
  subject = Activity.new

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without action' do
    subject.action = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without owner id' do
    subject.owner_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without trackable type' do
    subject.trackable_type = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a trackable id' do
    subject.trackable_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a company id' do
    subject.owner_id = nil
    expect(subject).to_not be_valid
  end

  describe 'Associations' do
    it 'belongs to owner' do
      assc = described_class.reflect_on_association(:owner)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to company' do
      assc = described_class.reflect_on_association(:company)
      expect(assc.macro).to eq :belongs_to
    end

    it 'belongs to trackable' do
      assc = described_class.reflect_on_association(:trackable)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
