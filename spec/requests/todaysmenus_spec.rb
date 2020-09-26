require 'rails_helper'

RSpec.describe "Todaysmenus", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/todaysmenus/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/todaysmenus/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
