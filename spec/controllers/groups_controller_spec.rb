require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @company = FactoryGirl.create(:company)
    @user.company = @company
    @user.role = User::ROLE[:admin]
    @user.save
    @request.host = "#{@company.subdomain}." + request.host
    sign_in @user
  end

  it 'renders the index template' do
    get :index
    expect(response).to render_template('index')
  end

  it 'renders the new template' do
    get :new
    expect(response).to render_template('new')
  end

  it 'does not render the index template on a different subdomain' do
    @request.host = '6vals.' + request.host
    get :index
    expect(response).to_not render_template('index')
  end

  it 'does not render the new template on a different subdomain' do
    @request.host = '6vals.' + request.host
    get :new
    expect(response).to_not render_template('new')
  end

  it 'does not render the index template for a signed out user' do
    sign_out @user
    get :index
    expect(response).to_not render_template('index')
  end

  it 'does not render the new template for a signed out user' do
    sign_out @user
    get :new
    expect(response).to_not render_template('new')
  end

  it 'successfully creates a valid group' do
    group_params = FactoryGirl.attributes_for(:group)# {first_name: 'first', last_name: 'last', email: 'email@example.example', role: 'member'}
    group_params[:user_ids] = [@user.id]
    expect { post :create, :group => group_params }.to change(Group, :count).by(1)
  end

  it 'does not create an invalid group' do
    group_params = FactoryGirl.attributes_for(:group)# {first_name: 'first', last_name: 'last', email: 'email@example.example', role: 'member'}
    # user missing from group
    expect { post :create, :group => group_params }.to change(Group, :count).by(0)
  end

  it 'does not create a valid group in a different subdomain' do
    @request.host = '6vals.' + request.host
    group_params = FactoryGirl.attributes_for(:group)# {first_name: 'first', last_name: 'last', email: 'email@example.example', role: 'member'}
    group_params[:user_ids] = [@user.id]
    expect { post :create, :group => group_params }.to change(Group, :count).by(0)
  end
end
