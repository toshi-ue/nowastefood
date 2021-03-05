require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  before do
    @user = create(:user)
    sign_in @user
  end

  # describe "GET /index" do
  #   context 'ユーザーがログインしているとき' do
  #     it 'indexページが表示されること' do
  #       cuisine = create(:cuisine, name: "料理1")
  #       cuisine2 = create(:cuisine, name: "料理2")
  #       favorite = create(:favorite, user_id: @user.id, cuisine_id: cuisine.id)
  #       favorite2 = create(:favorite, user_id: @user.id, cuisine_id: cuisine2.id)
  #       get favorites_path
  #       expect(response.status).to eq 200
  #       expect(response.body).to include "料理1"
  #       expect(response.body).to include "料理2"
  #     end
  #   end
  # end

  describe "POST /create" do
    context 'ログインしているとき' do
      it '登録できること' do
        cuisine = create(:cuisine)
        favorite = build(:favorite)
        expect do
          post favorites_path(cuisine_id: cuisine.id), params: {
            favorite: {
              user_id: @user.id, cuisine_id: cuisine.id
            }
          }, xhr: true
        end.to change(Favorite, :count).by(1)
      end
    end
  end

  describe "DELETE /destroy" do
    context 'ログインしているとき' do
      it '削除できること' do
        cuisine = create(:cuisine)
        favorite = create(:favorite, cuisine_id: cuisine.id, user_id: @user.id)
        expect do
          delete favorite_path(favorite.id), params: {
            favorite: {
              user_id: @user.id,
              cuisine_id: cuisine.id
            }
          }, xhr: true
        end.to change(Favorite, :count).by(-1)
      end
    end
  end
end
