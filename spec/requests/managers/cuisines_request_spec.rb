require 'rails_helper'

RSpec.describe "Managers::Cuisines", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/managers/cuisines/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/managers/cuisines/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/managers/cuisines/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
