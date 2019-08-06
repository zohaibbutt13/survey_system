require 'rails_helper'

RSpec.describe User, type: :model do
  let(:current_user) { User.new }

  it "is not valid without a first_name" do
    
    expect(group).to_not be_valid
  end

  it "is not valid without a last_name" do
    
  end

  it "is not valid without an email" do
    
  end
end