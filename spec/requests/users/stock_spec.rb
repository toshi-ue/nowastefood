require 'rails_helper'

RSpec.describe "Users::Stocks", type: :request do
  before do
    @user = create(:user)
    sign_in @user
    get root_path
  end

  describe "GET /index" do
    context "ログインしている場合" do
      it "indexページを表示すること" do
        (1..2).each do |n|
          create(:stock, user_id: @user.id, quantity: (n * 100).to_s)
        end
        get users_stocks_path
        expect(response.status).to eq 200
        expect(response.body).to include("100")
        expect(response.body).to include("200")
      end
    end

    context "ログインしていない場合" do
      it "サインインページへリダイレクトする" do
        sign_out @user
        get users_stocks_path
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response.body).to include("メールアドレス")
      end
    end
  end

  describe "GET /new" do
    context "ログインしている場合" do
      it "newページを表示する" do
        get new_users_stock_path
        expect(response.status).to eq 200
        expect(response.body).to include("食材名")
      end
    end

    context "ログインしていない場合" do
      it "サインインページへリダイレクトする" do
        sign_out @user
        get new_users_stock_path
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response.body).to include("メールアドレス")
      end
    end
  end

  describe "POST /create" do
    context "値が妥当な場合" do
      it "indexアクションへリダイレクトされること" do
        rawmaterial = create(:rawmaterial)
        expect{
          post users_stocks_path,
                params: { stock: attributes_for(:stock, user_id: @user.id, rawmaterial_id: rawmaterial.id, quantity: "1/2") }
        }.to change{Stock.count}.by(1)
        # expect(response.status).to eq 200
        expect(response).to redirect_to(users_stocks_path)
        follow_redirect!
        expect(response.body).to include("家にある食材")
      end
    end

    context "値が不当な場合" do
      it "newアクションにリダイレクトする" do
        rawmaterial = create(:rawmaterial)
        expect{
            post users_stocks_path,
                  params: { stock: attributes_for(:stock, user_id: @user.id, rawmaterial_id: rawmaterial.id, quantity: "") }
        }.to change{Stock.count}.by(0)
        expect(response.status).to eq 200
        expect(response.body).to include("食材名")
      end
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
