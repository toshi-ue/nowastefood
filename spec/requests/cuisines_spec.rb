# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cuisines' do
  before do
    @user = create(:user)
    sign_in @user
    @cuisine = create(:cuisine, :published)
  end

  describe 'GET /show' do
    it 'レシピ詳細が表示されること' do
      sign_out @user
      @rawmaterial = create(:rawmaterial)
      @foodstuff = create(:foodstuff, cuisine_id: @cuisine.id, rawmaterial_id: @rawmaterial.id)
      get cuisine_path @cuisine
      expect(response).to have_http_status :ok
      expect(response.body).to include @cuisine.name
      expect(response.body).to include @cuisine.foodstuffs.first.quantity
      expect(response.body).to include @cuisine.foodstuffs.first.rawmaterial.name
    end
  end

  describe 'POST /add_favorite' do
    context 'ユーザーでログインしているとき' do
      it 'favoriteに追加されること' do
        expect do
          post cuisine_add_favorite_path(@cuisine.id), xhr: true
        end.to change(Favorite, :count).by(1)
        expect(@user.already_favorite?(@cuisine)).to be(true)
      end
    end
  end

  describe 'POST /add_menu' do
    context 'ユーザーでログインしているとき' do
      it 'todaysmenuに追加されること' do
        expect do
          post cuisine_add_menu_path(@cuisine.id), xhr: true
        end.to change(Todaysmenu, :count).by(1)
        expect(@user.already_menu_in_today?(@cuisine.id)).to be(true)
      end
    end
  end

  describe 'DELTE /remove_favorite' do
    context 'ユーザーでログインしているとき' do
      it 'favoriteから削除されること' do
        favorite = create(:favorite, user_id: @user.id, cuisine_id: @cuisine.id) # rubocop:disable Lint/UselessAssignment
        expect do
          delete cuisine_remove_favorite_path(@cuisine.id), xhr: true
        end.to change(Favorite, :count).by(-1)
        expect(@user.already_favorite?(@cuisine)).to be(false)
      end
    end
  end

  describe 'DELETE /remove_menu' do
    context 'ユーザーでログインしているとき' do
      it 'todaysmenuから削除されること' do
        todaysmenu = create(:todaysmenu, user_id: @user.id, cuisine_id: @cuisine.id) # rubocop:disable Lint/UselessAssignment
        expect do
          delete cuisine_remove_menu_path(@cuisine.id), xhr: true
        end.to change(Todaysmenu, :count).by(-1)
        expect(@user.already_menu_in_today?(@cuisine.id)).to be(false)
      end
    end
  end
end
