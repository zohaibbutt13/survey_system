require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do

  describe "GET #dashboard" do
    it "returns http success" do
      get :dashboard
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #dashboard" do
    it "returns http success" do
      get :display_surveys
      expect(response).to have_http_status(:success)
    end
  end
end
