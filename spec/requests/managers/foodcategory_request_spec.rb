require 'rails_helper'

RSpec.describe "Foodcategories", type: :request do
  before do
    # foodcategoryのインスタンスを登録
    @foodcategory1 = create(:foodcategory, name: "aaa")

    # 管理者を作成し、ログイン
    # UNKNOWN: 管理者アカウントは作成しなくても良いか(seedデータで作成済)?
    manager = FactoryBot.create(:manager)
    sign_in manager
    # get authenticated_root_path
  end

  describe "GET #index" do
    it "リクエストが成功すること" do
      get managers_foodcategories_path
      expect(response.status).to eq 200
    end

    it "テンプレートの取得、インスタンスの取得ができること" do
      create(:foodcategory, name: "bbb")
      get managers_foodcategories_path
      # UNKNOWN: テンプレートの取得、インスタンスの取得ができることは業務でも同じような書き方か?
      expect(response.body).to include "aaa"
      expect(response.body).to include "bbb"
    end
  end

  describe "GET #new" do
    it "リクエストが成功すること" do
      get new_managers_foodcategory_path
      expect(response.status).to eq 200
    end

    it "newテンプレートで表示されること" do
      get new_managers_foodcategory_path
      expect(response.body).to include "食品区分名"
    end
  end

  describe "POST #create" do
    context "パラメーターが妥当な場合" do
      it "リクエストが成功すること" do
        post managers_foodcategories_path, params: { foodcategory: FactoryBot.attributes_for(:foodcategory) }
        expect(response.status).to eq 302
      end

      it "新規レコードが保存されること" do
        expect do
          post managers_foodcategories_path, params: { foodcategory: FactoryBot.attributes_for(:foodcategory) }
        end.to change(Foodcategory, :count).by(1)
      end

      it "(妥当なページへ)リダイレクトすること" do
        post managers_foodcategories_path, params: { foodcategory: FactoryBot.attributes_for(:foodcategory) }
        expect(response).to redirect_to managers_foodcategories_path
      end
    end

    context "パラメーターが不正な場合" do
      it "リクエストが成功すること" do
        post managers_foodcategories_path, params: { foodcategory: FactoryBot.attributes_for(:foodcategory) }
        expect(response.status).to eq 302
      end

      it "新規レコードが保存されないこと" do
        expect do
          post managers_foodcategories_path, params: { foodcategory: FactoryBot.attributes_for(:foodcategory, name: nil) }
        end.not_to change(Foodcategory, :count)
      end

      it "エラーを返す、表示されること" do
        post managers_foodcategories_path, params: { foodcategory: FactoryBot.attributes_for(:foodcategory, name: nil) }
        expect(response.body).to include "食品区分名を入力してください"
      end
    end
  end

  describe "GET #edit" do
    context "インスタンスが存在する場合" do
      it "リクエストが成功すること" do
        get edit_managers_foodcategory_path @foodcategory1
        expect(response.status).to eq 200
      end

      it "editテンプレートで表示されること(インスタンスのカラムが実際に表示されていること)" do
        get edit_managers_foodcategory_path @foodcategory1
        expect(response.body).to include "aaa"
      end
    end

    # UNKNOWN: インスタンスが存在しない場合のテストはどのように書けば良いのか?
    # context "インスタンスが存在しない場合" do
    #   it "エラーを返す(ActiveRecord::RecordNotFound)" do
    #     expect do
    #       get edit_managers_foodcategory_path 300
    #     end.to raise_error(ActiveRecord::RecordNotFound)
    #   end
    # end
  end

  describe "PATCH #update" do
    context "パラメーターが妥当な場合" do
      it "リクエストが成功すること" do
        # UNKNOWN: なぜ管理者としてログインしていないのにテストをパスするのか?
        # line9〜11が記述されていなくてもテストをパスする
        patch managers_foodcategory_path @foodcategory1, params: { foodcategory: FactoryBot.attributes_for(:foodcategory) }
        expect(response.status).to eq 302
      end

      it "既存レコードが更新されること" do
        expect do
          put managers_foodcategory_path @foodcategory1, params: { foodcategory: FactoryBot.attributes_for(:foodcategory, name: "bbb") }
        end.to change { Foodcategory.find(@foodcategory1.id).reload.name }.from("aaa").to("bbb")
      end

      it "(妥当なページへ)リダイレクトすること" do
        put managers_foodcategory_path @foodcategory1, params: { foodcategory: FactoryBot.attributes_for(:foodcategory, name: "bbb") }
        expect(response).to redirect_to managers_foodcategories_path
      end
    end

    # UNKNOW: updateアクションの異常系のテストは必要ないのか?
    # context "パラメーターが不正な場合" do
    #   it "リクエストが成功すること" do
    #     patch managers_foodcategory_path @foodcategory1, params: { foodcategory: FactoryBot.attributes_for(:foodcategory) }
    #     expect(response.status).to eq 302
    #   end

    # it "既存レコードが更新されないこと" do
    #   manager = FactoryBot.create(:manager)
    #   sign_in manager
    #   get authenticated_root_path
    #   expect do
    #     put managers_foodcategory_path @foodcategory1, params: { foodcategory: FactoryBot.attributes_for(:foodcategory, name: nil) }
    #   end.to_not change { Foodcategory.find(@foodcategory1.id).reload.name }.from("aaa").to(nil)
    # end
    # it "エラーを返す、表示されること(ActiveRecord::RecordNotFound)"
    # end
  end

  describe "DELETE #destroy" do
    it "リクエストが成功すること" do
      delete managers_foodcategory_path @foodcategory1
      expect(response.status).to eq 302
    end

    # it "既存レコードが削除されること" do
    #   expect do
    #     delete managers_foodcategory_path @foodcategory1
    #   end.to change(Foodcategory, :count).by(-1)
    # end

    it "(妥当なページへ)リダイレクトすること" do
      delete managers_foodcategory_path @foodcategory1
      expect(response).to redirect_to(managers_foodcategories_path)
    end
  end
end
