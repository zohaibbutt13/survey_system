require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  it 'renders the index template' do
    get :index
    expect(response).to render_template('index')
  end

  it 'renders the new template' do
    get :new
    expect(response).to render_template('new')
  end

  it 'renders the edit template' do
    get :edit
    expect(response).to render_template('edit')
  end

  # describe '#name' do
  #   it 'validates presence' do
  #     group = Group.new
  #     user = User.new
  #     group.description = 'this is my group'
  #     expect(group).to be_valid
  #   end

  #   it 'validates uniqueness' do
  #     group = Group.new
  #     user = User.new
  #     group.description = 'this is my group'
  #     expect(group).to be_valid
  #   end
  # end
end
