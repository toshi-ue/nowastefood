require 'rails_helper'

RSpec.describe "Todaysmenus", type: :request do
  before do
    @user = create(:user)
    sign_in @user
    get root_path
  end

  describe "GET /index" do
    context "ログインしているとき" do
      it "indexページを表示すること" do
        (1..2).each do |i|
          create(:todaysmenu, user_id: @user.id, serving_count: "#{i + 1}")
        end
        get todaysmenus_path
        expect(response.status).to eq 200
        expect(response.body).to include "1"
        expect(response.body).to include "2"
      end
    end

    context "ログインしていないとき" do
      it "ログイン画面へリダイレクトされること" do
        sign_out @user
        get todaysmenus_path
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response.body).to include "メールアドレス"
      end
    end
  end

  describe "GET /destroy" do
    it "削除できること" do
      other_todaysmenu1 = create(:todaysmenu, user_id: @user.id, serving_count: 6)
      other_todaysmenu2 = create(:todaysmenu, user_id: @user.id, serving_count: 10)
      todaysmenu = create(:todaysmenu)
      expect do
        delete todaysmenu_path(todaysmenu.id)
      end.to change{Todaysmenu.count}.by(-1)
      follow_redirect!
      expect(response.status).to eq 200
      expect(response.body).to include "6"
      expect(response.body).to include "10"
    end
  end

end
