require 'rails_helper'

RSpec.describe Group, type: :model do
  before(:each) do
    @group = FactoryGirl.build(:group)
    @group.users << FactoryGirl.build(:user)
  end

  it "is valid with valid inputs" do
    expect(@group).to be_valid
  end

  it "is not valid without a name" do
    @group.name = nil
    expect(@group).to_not be_valid
  end

  it "is not valid without a description" do
    @group.description = nil
    expect(@group).to_not be_valid
  end

  it "is not valid without at least one user" do
    @group.users = []
    expect(@group).to_not be_valid
  end

  it "is not valid without a unique name within the same company" do
    group2 = FactoryGirl.build(:group)
    group2.name = @group.name
    expect(group2).to_not be_valid
  end
end