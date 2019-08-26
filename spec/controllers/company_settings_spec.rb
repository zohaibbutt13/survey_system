require 'rails_helper'
require "cancan/matchers"

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
    @request.host = "#{@company.subdomain}.#{request.host}"
    sign_in @user
    @ability = Ability.new(@user)
  end

  let(:create_supervisor) {
    @supervisor = FactoryGirl.create(:user)
    @supervisor.company = @company
    @supervisor.role = User::ROLE[:supervisor]
    @supervisor.save
    sign_in @supervisor
    @supervisor_ability = Ability.new(@supervisor) 
  }

  let(:create_member) {
    @member = FactoryGirl.create(:user)
    @member.company = @company
    @member.role = User::ROLE[:member]
    @member.save
    sign_in @member
    @member_ability = Ability.new(@member) 
  }

  describe 'GET edit' do
    it 'returns http success' do
      render_template :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "Abilities" do
    it 'update company settings' do
      expect(@ability).to be_able_to(:update, @company_setting)
    end

    it 'edit company settings' do
      expect(@ability).to be_able_to(:edit, @company_setting)
    end

    it 'should not edit company settings' do
      create_supervisor
      expect(@supervisor_ability).to_not be_able_to(:edit, @company_setting)
    end

    it 'should not updtae company settings' do
      create_supervisor
      expect(@supervisor_ability).to_not be_able_to(:update, @company_setting)
    end

    it 'should not edit company settings' do
      create_member
      expect(@member_ability).to_not be_able_to(:edit, @company_setting)
    end

    it 'should not updtae company settings' do
      create_member
      expect(@member_ability).to_not be_able_to(:update, @company_setting)
    end
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

    context 'invalid attributes' do
      it 'locates the requested @company_setting' do
        put :update, id: @company_setting, company_setting: @company_setting_params
        assigns(:company_setting).should eq(@company_setting)
      end

      it 'does not change @company_setting attributes' do
        @company_setting_params[:max_questions] = nil
        put :update, id: @company_setting, company_setting: @company_setting_params
        @company_setting.reload
        @company_setting.max_questions.should_not eq(200)
      end

      it 're-renders the edit method' do
        @company_setting_params[:max_questions] = nil
        put :update, id: @company_setting, company_setting: @company_setting_params
        response.should render_template :edit
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