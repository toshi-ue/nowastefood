require 'rails_helper'

RSpec.describe "Managers::Foodstuffs", type: :request do
  before do
    manager = create(:manager)
    sign_in manager
    get root_path
    @cuisine = create(:cuisine)
  end

  # TODO: 最終的には必要ない
  describe "GET /index" do
  end

  describe "GET #new" do
    it "リクエストが成功すること" do
      get new_managers_foodstuff_path(cuisine_id: @cuisine.id)
      expect(response.status).to eq 200
    end

    it "newテンプレートで表示されること" do
      get new_managers_foodstuff_path(cuisine_id: @cuisine.id)
      expect(response.body).to include "食材を検索"
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
      expect(response.status).to eq 302
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
      expect(response.body).to include "#{@cuisine.name}"
    end
  end

  describe "GET #edit" do
    before do
      @foodstuff = create(:foodstuff)
    end

    it "リクエストが成功すること" do
      get edit_managers_foodstuff_path @foodstuff
      expect(response.status).to eq 200
    end

    # TODO: JS:trueを使用したテストが必要
    # it "editテンプレートで表示されること" do
    #   get edit_managers_foodstuff_path @foodstuff
    #   expect(response.body).to include "#{@foodstuff.rawmaterial.name}"
    # end
  end

  describe "PATCH #update" do
    before do
      @foodstuff = create(:foodstuff, quantity: "10")
    end

    it "既存レコードが更新されること" do
      put managers_foodstuff_path @foodstuff, params: {
        foodstuff:{
          cuisine_id: @foodstuff.cuisine_id,
          rawmaterial_id: @foodstuff.rawmaterial_id,
          quantity: "1/2"
        }
      }
      expect(Foodstuff.find_by(id: @foodstuff.id).quantity). to eq "1/2"
    end
    it "cuisine/showページヘリダイレクトすること" do
      put managers_foodstuff_path @foodstuff, params: {
        foodstuff:{
          cuisine_id: @foodstuff.cuisine_id,
          rawmaterial_id: @foodstuff.rawmaterial_id,
          quantity: "1/2"
        }
      }
      expect(response).to redirect_to(managers_cuisine_path( @foodstuff.cuisine_id))
    end
  end

  describe "DELETE #destroy" do
    before do
      @foodstuff = create(:foodstuff, quantity: "10")
    end

    it "リクエストが成功すること" do
      delete managers_foodstuff_path @foodstuff
      expect(response.status).to eq 302
    end

    it "既存レコードが削除されること" do
      expect do
        delete managers_foodstuff_path @foodstuff
      end.to change(Foodstuff, :count).by(-1)
    end

    it "cuisine/showページヘリダイレクトすること" do
      delete managers_foodstuff_path @foodstuff
      expect(response).to redirect_to(managers_cuisine_path( @foodstuff.cuisine_id))
    end
  end
end
