require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = FactoryGirl.build(:user)
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
end