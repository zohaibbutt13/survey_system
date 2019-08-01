require 'rails_helper'

RSpec.describe UserSettingsController, type: :controller do 

  before(:each) do
    @user = FactoryGirl.build(:user)
    @user.role = User::ROLE[:admin]
    @user.save
    sign_in @user
    #user_settings_attr = {id: 1, show_graphs:'1',show_history:'1',emails_subscription:'1'}
  end
  
  it 'renders the new template' do
    get :new
    expect(response).to render_template('new')
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'should save the new project in the database' do
        expect { post :create, user_settings: {emails_subscription:'1', show_graphs:'1', show_history:'1'} }
          .to change(UserSetting, :count).by(1)
        expect(flash[:notice]).to eq 'Successfully created a user seting.'
      end
      it "should redirect to that new project's page" do
        post :create, user_settings: user_settings_attr
        expect(response).to redirect_to UserSetting.last
      end
    end

    # context 'with invalid attributes' do
    #   it 'should not save the new project in the database' do
    #     expect do
    #       post :create, project: invalid_project_attr
    #     end.to_not change(Project, :count)
    #   end
    #   it 'should re-render the :new template' do
    #     post :create, project: invalid_project_attr
    #     expect(response).to render_template :new
    #   end
    # end
  end

  # describe 'GET #edit' do
  #   it 'returns response successfully' do
  #     params = {:id => user.id}
  #     get :edit , params
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end