# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Favorites' do
  before do
    @user = create(:user)
    sign_in @user
  end

  describe 'GET /index' do
    context 'ユーザーがログインしているとき' do
      it 'indexページが表示されること' do
        favorite = create(:favorite, user: @user)
        favorite2 = create(:favorite, user: @user)
        get favorites_path
        expect(response).to have_http_status :ok
        expect(response.body).to include favorite.cuisine.name
        expect(response.body).to include favorite2.cuisine.name
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'ログインしているとき' do
      it '削除できること' do
        favorite = create(:favorite)
        expect do
          delete favorite_path(favorite.id)
        end.to change(Favorite, :count).by(-1)
      end
    end
  end
end
