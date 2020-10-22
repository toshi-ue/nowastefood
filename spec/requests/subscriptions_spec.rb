require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  before do
    @user = create(:user)
    sign_in @user
    get root_path
  end

  describe "GET #show" do
    context "有料プランに加入しているとき" do
      it "リクエストが成功すること"
      it "showテンプレートで表示されること"
    end

    context "有料プランに加入していないとき" do
      it "リクエストが成功すること"
      it "showテンプレートで表示されること"
    end
  end

  describe "GET #create" do
    it "リクエストが成功すること"
    it "登録できること"
    it "リダイレクトすること"
  end

  describe "GET #destroy" do
    it "リクエストが成功すること"
    it "登録できること"
    it "リダイレクトすること"
  end
end
