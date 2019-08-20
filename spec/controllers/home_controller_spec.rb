require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #sign_in" do
    it "returns http success" do
      get :sign_in
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #companies_list" do
    it "should redirect to sign_in_home_index_path" do
      post :companies_list, @email= nil
      response.should redirect_to sign_in_home_index_path
    end

    it "should render companies_list" do
      post :companies_list, @email= 'ali.ahmad@7vals.com'
      @companies = Company.joins('INNER JOIN users on users.company_id = companies.id').where("users.email = ?", @email)
      expect(response).to_not render_template('companies_list')
    end
  end
end