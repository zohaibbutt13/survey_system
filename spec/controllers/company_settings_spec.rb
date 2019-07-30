require 'rails_helper'

RSpec.describe CompanySettingsController, type: :controller do
  # it 'returns response successfully' do
  #   get :new
  #   assert_response :success
  # end

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