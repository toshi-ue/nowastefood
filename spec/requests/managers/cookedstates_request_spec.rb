require 'rails_helper'

RSpec.describe "Managers::Cookedstates", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/managers/cookedstates/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/managers/cookedstates/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/managers/cookedstates/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
