require 'rails_helper'

RSpec.describe UserSettingsController, type: :controller do 

  it 'renders the new template' do
    get :new
    expect(response).to render_template('new')
  end

  describe 'GET #edit' do
    it 'returns response successfully' do
      params = {:id => '1'}
      get :edit , params
      expect(response).to have_http_status(:success)
    end
  end
end