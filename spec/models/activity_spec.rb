# spec/models/review_spec.rb
require 'rails_helper'

RSpec.describe Activity, :type => :model do
  subject = FactoryGirl.build(:activity)

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

  describe 'Getting user activities' do
    before(:each) do
      # Creating Users
      @admin_user = FactoryGirl.build(:admin_user)
      @supervisor_user = FactoryGirl.build(:supervisor_user)

      # Creating activities associated with admin
      admin_activity1 = FactoryGirl.create(:activity)
      admin_activity1.owner_id = @admin_user.id
      admin_activity1.save
      admin_activity2 = FactoryGirl.create(:activity)
      admin_activity2.owner_id = @admin_user.id
      admin_activity2.save
      @admin_user.activities << admin_activity1
      @admin_user.activities << admin_activity2

      # Creating activities associated with supervisor
      supervisor_activity1 = FactoryGirl.create(:activity)
      supervisor_activity1.owner_id = @supervisor_user.id
      supervisor_activity2 = FactoryGirl.create(:activity)
      supervisor_activity2.owner_id = @supervisor_user.id
      supervisor_activity3 = FactoryGirl.create(:activity)
      supervisor_activity3.owner_id = @supervisor_user.id
      @supervisor_user.activities << supervisor_activity1
      @supervisor_user.activities << supervisor_activity2
      @supervisor_user.activities << supervisor_activity3
    end

    # For admin all the acitivites of a company are returned
    it 'should return activities of a company' do
      activities = Activity.get_user_activities(@admin_user)
      expect(activities.count).to eq 5
    end

    it 'should return activities of a supervisor' do
      activities = Activity.get_user_activities(@supervisor_user)
      expect(activities.count).to eq 3
    end
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
