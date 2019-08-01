require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:current_user) { mock_model(User) }

  it "is not valid without a name" do
    group = Group.new
    expect(group).to_not be_valid
  end

  it "is not valid without a description" do
    group = Group.new
    group.name = 'title'
    expect(group).to_not be_valid
  end

  it "is not valid without at least one user" do
    group = Group.new
    group.name = 'title'
    group.description = 'group description'
    expect(group).to_not be_valid
  end

  it "is valid with valid inputs" do
    group = Group.new
    user = instance_double('User')
    group.name = 'title'
    group.description = 'group description'
    group.users << current_user
    expect(group).to be_valid
  end

  it "is not valid without a unique name within the same company" do
    group = Group.new
    user = User.new
    group.name = 'title'
    group.description = 'group description'
    group.users << current_user

    group2 = Group.new(name: 'title')
    expect(group2).to_not be_valid
  end
end