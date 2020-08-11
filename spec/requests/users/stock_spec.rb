require 'rails_helper'

RSpec.describe "Users::Stocks", type: :request do
  before do
    @user = create(:user)
    sign_in @user
    get root_path
  end

  describe "GET /index" do
    before do
      (1..2).each do |n|
        stock = create(:stock, quantity: ((n + 1) * 100).to_s)
        # puts stock
        # byebug
      end
    end

    context "ログインしている場合" do
      it "リクエストが成功すること" do
        get users_stocks_path
        expect(response.status).to eq 200
      end

      it "テンプレートの取得、インスタンスの取得ができる" do
        # get users_stocks_path
        # expect(response.body).to include("100")
      end
    end

    context "ログインしていない場合" do
      it "サインインページにリダイレクトする" do
        sign_out @user
        get users_stocks_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /new" do
    context "ログインしている場合" do
      it "リクエストが成功すること" do
        get new_users_stock_path
        expect(response.status).to eq 200
      end
    end

    context "ログインしていない場合" do
      it "サインインページにリダイレクトする" do
        sign_out @user
        get new_users_stock_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST /create" do
    context "ログインしている場合" do
      context "値が妥当な場合" do
        it "リクエストが成功すること" do
          expect{
            post users_stocks_path,
                 params: { stock: attributes_for(:stock, user_id: @user.id, quantity: "100") }
          }.to change{Stock.count}.by(1)
        end

        it "新規レコードが保存されること"
        it "(妥当なページへ)リダイレクトされること"
      end
    end

    context "ログインしていない場合" do
    end
  end

  describe "DELETE /destroy" do
    before do
      @stock = create(:stock)
    end
    it "インスタンスを削除できる" do
      expect{
        delete users_stock_path(@stock)
      }.to change{Stock.count}.by(-1)
    end
  end
end
