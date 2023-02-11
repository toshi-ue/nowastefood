# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cookinghistorys' do
  before do
    @user = create(:user)
    sign_in @user
    get root_path
    cuisine = create(:cuisine)
    @todaysmenu_yesterday = create(:todaysmenu, cuisine_id: cuisine.id, user_id: @user.id, created_at: Time.zone.now.yesterday.to_date)
  end

  describe 'GET /index' do
    before do
      @user.save!
      cuisine = create(:cuisine)
      @todaysmenu = create(:todaysmenu, cuisine_id: cuisine.id, cooked_when: 1, user_id: @user.id, created_at: Time.zone.now)
    end

    it 'indexページが表示されること' do
      get cookinghistorys_path
      expect(response).to have_http_status :ok
      expect(response.body).to include @todaysmenu.cuisine.name.to_s
    end
  end

  describe 'post add_to_todays_menu' do
    it '登録できること' do
      cuisine = create(:cuisine)

      expect do
        post cuisine_add_to_todays_menu_path(cuisine.id),
             params: { todaysmenu: attributes_for(:todaysmenu, user_id: @user.id, cuisine_id: cuisine.id, created_at: Time.zone.now.to_date) }
      end.to change(Todaysmenu, :count).by(1)
    end
  end

  describe 'delete remove_from_todays_menus' do
    it '削除できること' do
      cuisine = create(:cuisine)
      todaysmenu = create(:todaysmenu, cuisine_id: cuisine.id, user_id: @user.id) # rubocop:disable Lint/UselessAssignment
      expect do
        delete cuisine_remove_from_todays_menus_path(cuisine_id: cuisine.id)
      end.to change(Todaysmenu, :count).by(-1)
    end
  end
end
