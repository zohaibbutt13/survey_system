require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryGirl.build(:user)
    @company = FactoryGirl.create(:company)
    @subscription_package = FactoryGirl.create(:subscription_package)
    @company.subscription_package = @subscription_package
  end

  describe 'validations' do
    it "is valid with valid attributes" do
      expect(@user).to be_valid
    end

    it "is not valid without a first_name" do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end

    it "is not valid without a last_name" do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it "is not valid without an email" do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it "is not valid without a password" do
      @user.password = @user.password_confirmation = nil
      expect(@user).to_not be_valid
    end
  end

  context 'methods' do
    it 'should return true when calls user.admin?' do
      user = User.create(first_name: 'alex', role: User::ROLE[:admin])
      expect(user.admin?).to eq true
    end

    it 'should return true when calls user.member?' do
      user = User.create(first_name: 'alex', role: User::ROLE[:member])
      expect(user.member?).to eq true
    end

    it 'should return true when calls user.supervisor?' do
      user = User.create(first_name: 'alex', role: User::ROLE[:supervisor])
      expect(user.supervisor?).to eq true
    end

    it 'should return full name' do
      user = User.create(first_name: 'alex', last_name: 'bell')
      expect(user.full_name) == "#{user.first_name} #{user.last_name}"
    end

    it 'should return count of supervisors' do
      current_supervisors_count = @company.users.where(role: User::ROLE[:supervisor]).count
      max_supervisors = @company.subscription_package.max_supervisors
      @user.role = User::ROLE[:supervisor]
      expect(@user.supervisor? && current_supervisors_count < max_supervisors).to eq true
    end

    it 'should return count of members' do
      current_members_count = @company.users.where(role: User::ROLE[:member]).count
      max_members = @company.subscription_package.max_members
      @user.role = User::ROLE[:member]
      expect(@user.member? && current_members_count < max_members).to eq true
    end
  end
end