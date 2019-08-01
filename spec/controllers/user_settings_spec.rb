require 'rails_helper'

RSpec.describe UserSettingsController, type: :controller do 

  before(:each) do
    @user = FactoryBot.build(:user)
    @user.role = User::ROLE[:admin]
    @user.save
    sign_in @user
  end
  
  it 'renders the new template' do
    get :new
    expect(response).to render_template('new')
  end
end

RSpec.describe UserSettingsController, type: :routing do
  describe 'routing' do
    it 'should route to #new' do
      expect(get: '/user_settings/new').to route_to('user_settings#new')
    end

    it 'should route to #update via PUT' do
      expect(put: '/user_settings/1').to route_to('user_settings#update', id: '1')
    end

    it 'should route to #update via PATCH' do
      expect(patch: '/user_settings/1').to route_to('user_settings#update', id: '1')
    end

    it 'should route to #edit' do
      expect(get: '/user_settings/1/edit').to route_to('user_settings#edit', id: '1')
    end
  end
end