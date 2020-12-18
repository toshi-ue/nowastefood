require 'rails_helper'

RSpec.describe "Cuisines", type: :request do
  before do
    @user = create(:user)
    sign_in @user
    @cuisine = create(:cuisine)
  end

  describe "GET /show" do
    it "レシピ詳細が表示されること" do
      sign_out @user
      @rawmaterial = create(:rawmaterial)
      @foodstuff = create(:foodstuff, cuisine_id: @cuisine.id, rawmaterial_id: @rawmaterial.id)
      get cuisine_path @cuisine
      expect(response.status).to eq 200
      expect(response.body).to include @cuisine.name
      # expect(response.body).to include @cuisine.genre.name
      expect(response.body).to include @cuisine.foodstuffs.first.quantity
      expect(response.body).to include @cuisine.foodstuffs.first.rawmaterial.name
    end
  end

  describe "POST /add_favorite" do
    context "ユーザーでログインしているとき" do
      it "favoriteに追加されること" do
        expect do
          post cuisine_add_favorite_path(@cuisine.id), xhr: true
        end.to change(Favorite, :count).by(1)
        expect(@user.already_favorite?(@cuisine)).to eq(true)
      end
    end
  end

  describe "POST /add_menu" do
    context "ユーザーでログインしているとき" do
      it "todaysmenuに追加されること" do
        expect do
          post cuisine_add_menu_path(@cuisine.id), xhr: true
        end.to change(Todaysmenu, :count).by(1)
        expect(@user.already_menu_in_today?(@cuisine.id)).to eq(true)
      end
    end
  end

  describe "DELTE /remove_favorite" do
    context "ユーザーでログインしているとき" do
      it "favoriteから削除されること" do
        favorite = create(:favorite, user_id: @user.id, cuisine_id: @cuisine.id)
        expect do
          delete cuisine_remove_favorite_path(@cuisine.id), xhr: true
        end.to change(Favorite, :count).by(-1)
        expect(@user.already_favorite?(@cuisine)).to eq(false)
      end
    end
  end

  describe "DELETE /remove_menu" do
    context "ユーザーでログインしているとき" do
      it "todaysmenuから削除されること" do
        todaysmenu = create(:todaysmenu, user_id: @user.id, cuisine_id: @cuisine.id)
        expect do
          delete cuisine_remove_menu_path(@cuisine.id), xhr: true
        end.to change(Todaysmenu, :count).by(-1)
        expect(@user.already_menu_in_today?(@cuisine.id)).to eq(false)
      end
    end
  end
end
