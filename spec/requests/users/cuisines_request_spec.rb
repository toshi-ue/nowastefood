require 'rails_helper'

RSpec.describe "Users::Cuisines", type: :request do

  describe "GET /show" do
    it "returns http success" do
      get "/users/cuisines/show"
      expect(response).to have_http_status(:success)
    end
  end

end
