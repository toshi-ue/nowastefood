require 'rails_helper'

RSpec.describe "Cookinghistorys", type: :request do
  before do
    @user = create(:user)
    sign_in @user
    get root_path
    cuisine = create(:cuisine)
    @todaysmenu_yesterday = create(:todaysmenu, cuisine_id: cuisine.id, user_id: @user.id, created_at: Time.zone.now.yesterday.to_date)
  end

  describe "GET /index" do
    before do
      @user.save!
      cuisine = create(:cuisine)
      @todaysmenu_gt_5days1 = create(:todaysmenu, cuisine_id: cuisine.id, user_id: @user.id, created_at: Time.zone.now.ago(5.days).to_date)
    end

    it "indexページが表示されること" do
      get cookinghistorys_path
      expect(response.status).to eq 200
      expect(response.body).to include @todaysmenu_yesterday.cuisine.name.to_s
    end

    # TODO: 作成していないレシピを表示させないようにする
    it "当日のtodaysmenuが表示されないこと" do
      cuisine = create(:cuisine)
      @todaysmenu_today = create(:todaysmenu, cuisine_id: cuisine.id, user_id: @user.id, created_at: Time.zone.now.to_date)
      get cookinghistorys_path
      expect(response.status).to eq 200
      expect(response.body).not_to include @todaysmenu_today.cuisine.name.to_s
    end

    it "5日以上前のtodaysmenuが表示されること" do
      get cookinghistorys_path
      expect(response.status).to eq 200
      expect(response.body).to include @todaysmenu_gt_5days1.cuisine.name.to_s
    end
  end

  describe "post add_to_todays_menu" do
    it "登録できること" do
      cuisine = create(:cuisine)
      todaysmenu = build(:todaysmenu, cuisine_id: cuisine.id, user_id: @user.id)
      expect do
        post cuisine_add_to_todays_menu_path(cuisine.id),
             params: { todaysmenu: attributes_for(:todaysmenu, user_id: @user.id, cuisine_id: cuisine.id, created_at: Time.zone.now.to_date) }
      end.to change(Todaysmenu, :count).by(1)
    end
  end

  describe "delete remove_from_todays_menus" do
    it "削除できること" do
      cuisine = create(:cuisine)
      todaysmenu = create(:todaysmenu, cuisine_id: cuisine.id, user_id: @user.id)
      expect do
        delete cuisine_remove_from_todays_menus_path(cuisine_id: cuisine.id)
      end.to change(Todaysmenu, :count).by(-1)
    end
  end
end
