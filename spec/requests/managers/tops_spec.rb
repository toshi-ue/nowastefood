require 'rails_helper'

RSpec.describe "Managers::Tops", type: :request do
  describe "GET /dashboard" do
    it "returns http success" do
      get "/managers/tops/dashboard"
      expect(response).to have_http_status(:success)
    end
  end

end
