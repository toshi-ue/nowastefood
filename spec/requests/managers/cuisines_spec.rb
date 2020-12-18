require 'rails_helper'

RSpec.describe "Managers::Cuisines", type: :request do
  before do
    @manager = create(:manager)
    sign_in @manager
  end

  describe "GET /index" do
    it "indexページが表示されること" do
      cuisine1 = create(:cuisine)
      cuisine2 = create(:cuisine)
      get managers_cuisines_path
      expect(response.status).to eq 200
      expect(response.body).to include "料理レシピ一覧"
      expect(response.body).to include cuisine1.name
      expect(response.body).to include cuisine2.name
    end
  end

  describe "GET /new" do
    it "newページが表示されること" do
      get new_managers_cuisine_path
      expect(response.status).to eq 200
      expect(response.body).to include "レシピ名"
    end
  end

  describe "GET /edit" do
    it "editページが表示されること" do
      cuisine = create(:cuisine)
      get edit_managers_cuisine_path cuisine.id
      expect(response.status).to eq 200
      expect(response.body).to include cuisine.name
    end
  end
end
