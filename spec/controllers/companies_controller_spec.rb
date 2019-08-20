require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @company = FactoryGirl.create(:company)
    @user.company = @company
    @user.role = User::ROLE[:admin]
    @user.save
    @company_params = FactoryGirl.attributes_for(:company)
    @request.host = "#{@company.subdomain}." + request.host
    sign_in @user
  end

  describe "GET #dashboard" do
    it "returns http success" do
      get :dashboard
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #display_surveys" do
    it "returns http success" do
      get :display_surveys
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #subscription_packages" do
    it "returns http success" do
      get :subscription_packages
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT update' do
    context 'valid attributes' do
      it 'locates the requested @company' do
        put :update, id: @company, company: @company_params
        assigns(:company).should eq(@company)
      end

      it 'changes @company attributes' do
        @company_params[:subscription_package_id] = 2
        put :update, id: @company, company: @company_params
        @company.reload
        @company.subscription_package_id.should eq(2)
      end

      it 'redirects to the updated dashboard' do
        put :update, id: @company, company: @company_params
        response.should redirect_to dashboard_company_path
      end
    end
  end

end