# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Managers::Foodstuffs" do
  before do
    manager = create(:manager)
    sign_in manager
    get root_path
    @cuisine = create(:cuisine)
  end

  describe "GET #new" do
    it "リクエストが成功すること" do
      get new_managers_foodstuff_path(cuisine_id: @cuisine.id)
      expect(response).to have_http_status :ok
    end

    it "newテンプレートで表示されること" do
      get new_managers_foodstuff_path(cuisine_id: @cuisine.id)
      expect(response.body).to include "new-managers-foodstuffs"
    end
  end

  describe "POST #create" do
    before do
      @rawmaterial = create(:rawmaterial)
    end

    it "リクエストが成功すること" do
      post managers_foodstuffs_path, params: {
        foodstuff: {
          cuisine_id: @cuisine.id,
          rawmaterial_id: @rawmaterial.id,
          quantity: 1
        }
      }
      expect(response).to have_http_status :found
    end

    it "新規レコードが作成されること" do
      expect do
        post managers_foodstuffs_path, params: {
          foodstuff: {
            cuisine_id: @cuisine.id,
            rawmaterial_id: @rawmaterial.id,
            quantity: 1
          }
        }
      end.to change(Foodstuff, :count).by(1)
    end

    it "cuisine/showページへリダイレクトすること" do
      post managers_foodstuffs_path, params: {
        foodstuff: {
          cuisine_id: @cuisine.id,
          rawmaterial_id: @rawmaterial.id,
          quantity: 1
        }
      }
      follow_redirect!
      expect(response.body).to include @cuisine.name.to_s
    end
  end

  describe "GET #edit" do
    it "リクエストが成功すること" do
      @foodstuff = create(:foodstuff, cuisine_id: @cuisine.id)
      get edit_managers_foodstuff_path(@foodstuff, cuisine_id: @cuisine.id)
      expect(response).to have_http_status :ok
    end
  end

  describe "PATCH #update" do
    before do
      @foodstuff = create(:foodstuff, quantity: "10")
    end

    it "既存レコードが更新されること" do
      put managers_foodstuff_path @foodstuff, params: {
        foodstuff: {
          cuisine_id: @foodstuff.cuisine_id,
          rawmaterial_id: @foodstuff.rawmaterial_id,
          quantity: "1/2"
        }
      }
      expect(Foodstuff.find_by(id: @foodstuff.id).quantity). to eq "1/2"
    end

    it "cuisine/showページヘリダイレクトすること" do
      put managers_foodstuff_path @foodstuff, params: {
        foodstuff: {
          cuisine_id: @foodstuff.cuisine_id,
          rawmaterial_id: @foodstuff.rawmaterial_id,
          quantity: "1/2"
        }
      }
      expect(response).to redirect_to(managers_cuisine_path(@foodstuff.cuisine_id))
    end
  end

  describe "DELETE #destroy" do
    before do
      @foodstuff = create(:foodstuff, quantity: "10")
    end

    it "リクエストが成功すること" do
      delete managers_foodstuff_path @foodstuff
      expect(response).to have_http_status :found
    end

    it "既存レコードが削除されること" do
      expect do
        delete managers_foodstuff_path @foodstuff
      end.to change(Foodstuff, :count).by(-1)
    end

    it "foodstuffs#newページヘリダイレクトすること" do
      delete managers_foodstuff_path @foodstuff
      expect(response).to redirect_to(new_managers_foodstuff_path(cuisine_id: @foodstuff.cuisine_id))
    end
  end
end
