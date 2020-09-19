# TODO: specのテストを追加する
require 'rails_helper'

RSpec.describe "Tops", type: :request do

  describe "GET /about" do
    it "returns http success" do
      get "/tops/about"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /mygithub" do
    it "returns http success" do
      get "/tops/mygithub"
      expect(response).to have_http_status(:success)
    end
  end

end
