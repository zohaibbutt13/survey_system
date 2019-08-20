require 'rails_helper'

RSpec.describe UserSettingsController, type: :controller do 
  before(:each) do
    @user = FactoryGirl.create(:user)
    @company = FactoryGirl.create(:company)
    @user_setting = FactoryGirl.create(:user_setting)
    @user.company = @company
    @user.user_setting = @user_setting
    @user_setting_params = FactoryGirl.attributes_for(:user_setting)
    @user.role = User::ROLE[:admin]
    @user.save
    @request.host = "#{@company.subdomain}." + request.host
    sign_in @user
  end
  
  describe 'GET edit' do
    it 'has a 200 status code' do
      render_template :edit
      expect(response.status).to eq(200)
    end
  end
  
  describe 'PUT update' do
    context 'valid attributes' do
      it 'locates the requested @user_setting' do
        put :update, id: @user_setting, user_setting: @user_setting_params
        assigns(:user_setting).should eq(@user_setting)
      end

      it 'changes @user_setting attributes' do
        @user_setting_params[:show_graphs] = false
        @user_setting_params[:show_history] = false
        put :update, id: @user_setting, user_setting: @user_setting_params
        @user_setting.reload
        @user_setting.show_graphs.should eq(false)
        @user_setting.show_history.should eq(false)
      end

      it 'redirects to the dashboard' do
        put :update, id: @user_setting, user_setting: @user_setting_params
        response.should redirect_to dashboard_company_path
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @user_setting' do
        put :update, id: @user_setting, user_setting: @user_setting_params
        assigns(:user_setting).should eq(@user_setting)
      end

      it 'does not change @user_setting attributes' do
        @user_setting_params[:show_graphs] = nil
        put :update, id: @user_setting, user_setting: @user_setting_params
        @user_setting.reload
        @user_setting.show_graphs.should_not eq(false)
      end

      it 're-renders the edit method' do
        @user_setting_params[:show_graphs] = nil
        put :update, id: @user_setting, user_setting: @user_setting_params
        response.should render_template :edit
      end
    end
  end

  describe "Abilities" do
    it 'update user settings' do
      expect(@ability).to be_able_to(:update, @user_setting)
    end

    it 'edit user settings' do
      expect(@ability).to be_able_to(:edit, @user_setting)
    end
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