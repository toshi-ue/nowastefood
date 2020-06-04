require 'rails_helper'

RSpec.describe "Managers::Ingredients", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/managers/ingredients/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/managers/ingredients/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/managers/ingredients/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
