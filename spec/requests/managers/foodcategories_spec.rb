# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Foodcategories" do
  before do
    # foodcategoryのインスタンスを登録
    @foodcategory1 = create(:foodcategory, name: "aaa")
    # 管理者を作成し、ログイン
    manager = create(:manager)
    sign_in manager
    get root_path
  end

  describe "GET #index" do
    it "リクエストが成功すること" do
      get managers_foodcategories_path
      expect(response).to have_http_status :ok
    end

    it "テンプレートの取得、インスタンスの取得ができること" do
      create(:foodcategory, name: "bbb")
      get managers_foodcategories_path
      expect(response.body).to include "aaa"
      expect(response.body).to include "bbb"
    end
  end

  describe "GET #new" do
    it "リクエストが成功すること" do
      get new_managers_foodcategory_path
      expect(response).to have_http_status :ok
    end

    it "newテンプレートで表示されること" do
      get new_managers_foodcategory_path
      expect(response.body).to include "食品区分名"
    end
  end

  describe "POST #create" do
    context "パラメーターが妥当な場合" do
      it "リクエストが成功すること" do
        post managers_foodcategories_path, params: { foodcategory: attributes_for(:foodcategory) }
        expect(response).to have_http_status :found
      end

      it "新規レコードが保存されること" do
        expect do
          post managers_foodcategories_path, params: { foodcategory: attributes_for(:foodcategory) }
        end.to change(Foodcategory, :count).by(1)
      end

      it "(妥当なページへ)リダイレクトすること" do
        post managers_foodcategories_path, params: { foodcategory: attributes_for(:foodcategory) }
        expect(response).to redirect_to managers_foodcategories_path
      end
    end

    context "パラメーターが不正な場合" do
      it "リクエストが成功すること" do
        post managers_foodcategories_path, params: { foodcategory: attributes_for(:foodcategory) }
        expect(response).to have_http_status :found
      end

      it "新規レコードが保存されないこと" do
        expect do
          post managers_foodcategories_path, params: { foodcategory: attributes_for(:foodcategory, name: nil) }
        end.not_to change(Foodcategory, :count)
      end

      it "エラーを返す、表示されること" do
        post managers_foodcategories_path, params: { foodcategory: attributes_for(:foodcategory, name: nil) }
        expect(response.body).to include "食品区分名を入力してください"
      end
    end
  end

  describe "GET #edit" do
    context "インスタンスが存在する場合" do
      it "リクエストが成功すること" do
        get edit_managers_foodcategory_path @foodcategory1
        expect(response).to have_http_status :ok
      end

      it "editテンプレートで表示されること" do
        get edit_managers_foodcategory_path @foodcategory1
        expect(response.body).to include "aaa"
      end
    end
  end

  describe "PATCH #update" do
    context "パラメーターが妥当な場合" do
      it "リクエストが成功すること" do
        patch managers_foodcategory_path @foodcategory1, params: { foodcategory: attributes_for(:foodcategory) }
        expect(response).to have_http_status :found
      end

      it "既存レコードが更新されること" do
        expect do
          put managers_foodcategory_path @foodcategory1, params: { foodcategory: attributes_for(:foodcategory, name: "bbb") }
        end.to change { Foodcategory.find(@foodcategory1.id).reload.name }.from("aaa").to("bbb")
      end

      it "(妥当なページへ)リダイレクトすること" do
        put managers_foodcategory_path @foodcategory1, params: { foodcategory: attributes_for(:foodcategory, name: "bbb") }
        expect(response).to redirect_to managers_foodcategories_path
      end
    end
  end

  describe "DELETE #destroy" do
    it "リクエストが成功すること" do
      delete managers_foodcategory_path @foodcategory1
      expect(response).to have_http_status :found
    end

    it "既存レコードが削除されること" do
      expect do
        delete managers_foodcategory_path @foodcategory1
      end.to change(Foodcategory, :count).by(-1)
    end

    it "(妥当なページへ)リダイレクトすること" do
      delete managers_foodcategory_path @foodcategory1
      expect(response).to redirect_to(managers_foodcategories_path)
    end
  end
end
