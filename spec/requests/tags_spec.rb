require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "GET /search" do
    before do
      @cuisine = create(:cuisine, name: "aaa")
      @cuisine.tag_list.add("ccc", "ddd")
      @cuisine.save
      @another_cuisine = create(:cuisine, name: "bbb")
      @another_cuisine.tag_list.add("ccc")
      @another_cuisine.save
    end

    it "リクエストが成功すること、searchテンプレートで表示されること" do
      get tag_search_path(tag_name: "ccc")
      expect(response.status).to eq 200
      expect(response.body).to include "aaa"
      expect(response.body).to include "bbb"
    end
  end
end
