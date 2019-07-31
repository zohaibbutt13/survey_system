require 'rails_helper'

RSpec.describe CompanySettingsController, type: :controller do

  it 'renders the new template' do
    get :new
    expect(response).to render_template('new')
  end
end

RSpec.describe CompanySettingsController, type: :routing do
  describe 'routing' do
    it 'should route to #new' do
      expect(get: '/company_settings/new').to route_to('company_settings#new')
    end

    it 'should route to #update via PUT' do
      expect(put: '/company_settings/1').to route_to('company_settings#update', id: '1')
    end

    it 'should route to #update via PATCH' do
      expect(patch: '/company_settings/1').to route_to('company_settings#update', id: '1')
    end

    it 'should route to #edit' do
      expect(get: '/company_settings/1/edit').to route_to('company_settings#edit', id: '1')
    end
  end
end