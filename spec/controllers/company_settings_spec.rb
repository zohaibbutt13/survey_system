require 'rails_helper'

RSpec.describe CompanySettingsController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @company = FactoryGirl.create(:company)
    @company_setting = FactoryGirl.create(:company_setting)
    @user.company = @company
    @company.company_setting = @company_setting
    @company_setting_params = FactoryGirl.attributes_for(:company_setting)
    @user.role = User::ROLE[:admin]
    @user.save
    @request.host = "#{@company.subdomain}." + request.host
    sign_in @user
  end

  describe 'PUT update' do
    context 'valid attributes' do
      it 'locates the requested @company_setting' do
        put :update, id: @company_setting, company_setting: @company_setting_params
        assigns(:company_setting).should eq(@company_setting)
      end

      it 'changes @company_setting attributes' do
        @company_setting_params[:max_questions] = 200
        @company_setting_params[:supervisors_settings_permission] = false
        put :update, id: @company_setting, company_setting: @company_setting_params
        @company_setting.reload
        @company_setting.max_questions.should eq(200)
        @company_setting.supervisors_settings_permission.should eq(false)
      end

      it 'redirects to the updated dashboard' do
        put :update, id: @company_setting, company_setting: @company_setting_params
        response.should redirect_to dashboard_company_path
      end
    end
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