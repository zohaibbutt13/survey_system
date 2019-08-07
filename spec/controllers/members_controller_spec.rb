require 'rails_helper'

RSpec.describe MembersController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @company = FactoryGirl.create(:company)
    @user.company = @company
    @user.role = User::ROLE[:admin]
    @user.save
    @request.host = "#{@company.subdomain}." + request.host
    sign_in @user
  end

  describe 'GET #new' do
    it 'returns http success' do 
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'does not return http success on different subdomain' do
      @request.host = '6vals'. + request.host
      get :new
      expect(response).to_not have_http_status(:success)
    end
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'does not return http success on different subdomain' do
      @request.host = '6vals.' + request.host
      get :index
      expect(response).to_not have_http_status(:success)
    end
  end

  describe 'Create Member' do
    it 'successfully creates a valid member' do
      member_params = {first_name: 'first', last_name: 'last', email: 'email@example.example', role: 'member'}
      expect { post :create, :user => member_params }.to change(User, :count).by(1)
    end

    it 'does not create a member on different subdomain' do
      @request.host = '6vals.' + request.host
      member_params = {first_name: 'first', last_name: 'last', email: 'email@example.example', role: 'member'}
      expect { post :create, :user => member_params }.to change(User, :count).by(0)
    end
  end
end
