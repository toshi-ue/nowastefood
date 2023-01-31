# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Todaysmenus" do
  before do
    @user = create(:user)
    sign_in @user
    get root_path
  end

  describe "GET /index" do
    context "ログインしているとき" do
      it "indexページを表示すること" do
        (1..2).each do |i|
          create(:todaysmenu, user_id: @user.id, serving_count: (i + 1).to_s)
        end
        get todaysmenus_path

        aggregate_failures "testing response" do
          expect(response).to have_http_status :ok
          expect(response.body).to include "1"
          expect(response.body).to include "2"
        end
      end
    end

    context "ログインしていないとき" do
      it "ログイン画面へリダイレクトされること" do
        sign_out @user
        get todaysmenus_path

        aggregate_failures "testing response" do
          expect(response).to have_http_status :found
          expect(response).to redirect_to(new_user_session_path)
          follow_redirect!
          expect(response.body).to include "メールアドレス"
        end
      end
    end
  end

  describe "GET /destroy" do
    it "削除できること" do
      # other_todaysmenu1 = create(:todaysmenu, user_id: @user.id, serving_count: 6)
      # other_todaysmenu2 = create(:todaysmenu, user_id: @user.id, serving_count: 10)
      todaysmenu = create(:todaysmenu)
      expect do
        delete todaysmenu_path(todaysmenu.id)
      end.to change(Todaysmenu, :count).by(-1)
      follow_redirect!
      expect(response).to have_http_status :ok
      expect(response.body).to include "6"
      expect(response.body).to include "10"
    end
  end
end
