require 'rails_helper'

RSpec.describe "Genres", type: :request do
  describe "GET /search" do
    before do
      @cuisine = create(:cuisine, name: "aaa")
      @another_cuisine = create(:cuisine, name: "bbb", genre_id: @cuisine.genre_id)
    end

    it "リクエストが成功すること、searchテンプレートで表示されること" do
      get genres_search_path(id: @cuisine.genre_id)
      expect(response.status).to eq 200
      expect(response.body).to include "aaa"
      expect(response.body).to include "bbb"
    end
  end
end
