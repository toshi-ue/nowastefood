require 'rails_helper'

RSpec.describe "Stocks", type: :request do
  before do
    @user = create(:user)
    sign_in @user
    get root_path
  end

  describe "GET /index" do
    context "ログインしているとき" do
      it "indexページを表示すること" do
        (1..2).each do |n|
          create(:stock, user_id: @user.id, quantity: (n * 100).to_s)
        end
        get stocks_path
        expect(response.status).to eq 200
        expect(response.body).to include("100")
        expect(response.body).to include("200")
      end
    end

    context "ログインしていないとき" do
      it "サインインページへリダイレクトすること" do
        sign_out @user
        get stocks_path
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response.body).to include("メールアドレス")
      end
    end
  end

  describe "GET /new" do
    context "ログインしているとき" do
      it "newページを表示すること" do
        get new_stock_path
        expect(response.status).to eq 200
        expect(response.body).to include("食材名")
      end
    end

    context "ログインしていないとき" do
      it "サインインページへリダイレクトすること" do
        sign_out @user
        get new_stock_path
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response.body).to include("メールアドレス")
      end
    end
  end

  describe "POST /create" do
    context "ログインしているとき" do
      context "値が妥当なとき" do
        it "indexアクションへリダイレクトされること" do
          rawmaterial = create(:rawmaterial)
          expect do
            post stocks_path,
                 params: { stock: attributes_for(:stock, user_id: @user.id, rawmaterial_id: rawmaterial.id, quantity: "1/2") }
          end.to change(Stock, :count).by(1)
          expect(response).to redirect_to(stocks_path)
          follow_redirect!
          expect(response.body).to include("家にある食材")
        end
      end

      context "値が不当なとき" do
        it "newアクションにリダイレクトすること" do
          rawmaterial = create(:rawmaterial)
          expect do
            post stocks_path,
                 params: { stock: attributes_for(:stock, user_id: @user.id, rawmaterial_id: rawmaterial.id, quantity: "") }
          end.to change(Stock, :count).by(0)
          expect(response.status).to eq 200
          expect(response.body).to include("食材名")
        end
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      @stock = create(:stock, user_id: @user.id)
    end

    it "インスタンスが削除できること" do
      expect do
        delete stock_path(@stock)
      end.to change(Stock, :count).by(-1)
    end

    it "indexページへリダイレクトされること" do
      (1..2).each do |n|
        create(:stock, user_id: @stock.user_id, quantity: (n * 100).to_s)
      end

      delete stock_path(@stock)
      follow_redirect!
      expect(response.body).to include "100"
      expect(response.body).to include "200"
    end
  end
end
