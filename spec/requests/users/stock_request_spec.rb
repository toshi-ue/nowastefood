require 'rails_helper'

RSpec.describe "Users::Stocks", type: :request do
  describe "GET /index" do
    it "リクエストが成功すること"
    it "テンプレートの取得、インスタンスの取得ができる"
  end

  # describe "GET /show" do
  # end

  describe "GET /new" do
    it "リクエストが成功すること"
    it "newテンプレートで表示されること"
  end

  describe "POST /create" do
    it "リクエストが成功すること"
    it "新規レコードが保存されること"
    it "(妥当なページへ)リダイレクトされること"
  end

  # describe "GET /edit" do
  #   it "リクエストが成功すること"
  #   it "editテンプレートが表示されること"
  # end

  describe "PUT /update" do
    it "リクエストが成功すること"
    it "既存レコードが更新されること"
    it "xxxへリダイレクトされること"
  end

  # describe "DELETE /destroy" do
  # end
end
