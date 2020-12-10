require 'rails_helper'

RSpec.describe "Cuisines", type: :request do
  before do
    @user = create(:user)
    sign_in @user
  end

  describe "GET /show" do
    it "レシピ詳細が表示されること" do
      sign_out @user
      @cuisine = create(:cuisine)
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
        @cuisine = create(:cuisine)
        expect do
          post cuisine_add_favorite_path @cuisine.id, xhr: true
        end.to change(Favorite, :count).by(1)
        # expect(@user.already_favorite?(@cuisine)).to eq(true)
      end
    end
  end

  # describe "POST /add_menu" do
  #   context "ユーザーでログインしているとき" do
  #     it "todaysmenuに追加されること" do
  #     end
  #   end
  # end

  # describe "/remove_favorite" do
  #   context "ユーザーでログインしているとき" do
  #     it "favoriteから削除されること"
  #   end
  # end

  # describe "remove_menu" do
  #   context "ユーザーでログインしているとき" do
  #     it "todaysmenuから削除されること"
  #   end
  # end
end
