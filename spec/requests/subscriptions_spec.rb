require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  before do
    @user = create(:user)
    sign_in @user
  end

  describe "GET #show" do
    context "有料プランのとき" do
      it "有料プランと表示されること" do
        @user.subscribed = true
        @user.save!
        get user_subscription_path
        expect(response.status).to eq 200
        expect(response.body).to include "有料プラン"
      end
    end

    context "無料プランのとき" do
      it "無料プランと表示されること" do
        @user.subscribed = false
        @user.save!
        get user_subscription_path
        expect(response.status).to eq 200
        expect(response.body).to include "無料プラン"
      end
    end
  end

  describe "GET #create" do
    it "有料プランに変更されること" do
      @user.subscribed = false
      @user.save!
      post register_subscription_path
      expect(response.status).to eq 302
      expect(response).to redirect_to(user_subscription_path)
      follow_redirect!
      expect(response.body).to include "有料プラン"
    end
  end

  describe "GET #destroy" do
    it "無料プランに変更されること" do
      @user.subscribed = true
      @user.save!
      delete cancel_subscription_path
      expect(response.status).to eq 302
      expect(response).to redirect_to(user_subscription_path)
      follow_redirect!
      expect(response.body).to include "無料プラン"
    end
  end
end
