require 'rails_helper'

RSpec.describe "Managers::Procedures", type: :request do
  before do
    manager = create(:manager)
    sign_in manager
    get root_path
    @cuisine = create(:cuisine)
  end

  # TODO: テストを追加する
  # describe "GET /show" do
  # end

  describe "GET /new" do
    it "リクエストが成功すること" do
      get new_managers_procedure_path(cuisine_id: @cuisine.id)
      expect(response.status).to eq 200
    end

    it "newテンプレートで表示されること" do
      get new_managers_procedure_path(cuisine_id: @cuisine.id)
      expect(response.body).to include "説明文"
    end
  end

  describe "GET /create" do
    context "OK" do
      it "リクエストが成功後、newテンプレートへリダイレクトすること" do
        post managers_procedures_path, params: {
          procedure: {
            cooking_detail: "valid_cooking_detail",
            cuisine_id: @cuisine.id
          }
        }
        expect(response.status).to eq 302
        follow_redirect!
        expect(response.body).to include "説明文"
      end

      it "新規レコードが作成されること" do
        expect do
          post managers_procedures_path, params: {
            procedure: {
              cooking_detail: "valid_cooking_detail",
              cuisine_id: @cuisine.id
            }
          }
        end.to change(Procedure, :count).by(1)
      end
    end

    context "NG" do
      it "リクエストが成功すること" do
        post managers_procedures_path, params: {
          procedure: {
            cooking_detail: "",
            cuisine_id: @cuisine.id
          }
        }
        expect(response.status).to eq 200
      end

      it "登録されないこと" do
        expect do
          post managers_procedures_path, params: {
            procedure: {
              cooking_detail: "",
              cuisine_id: @cuisine.id
            }
          }
        end.not_to change(Procedure, :count)
      end

      it "エラーメッセージが表示されること" do
        post managers_procedures_path, params: {
          procedure: {
            cooking_detail: "",
            cuisine_id: @cuisine.id
          }
        }
        expect(response.body).to include "手順を入力してください"
      end

      it "必要な情報が表示されていること" do
        @procedure2 = create(:procedure, cuisine_id: @cuisine.id, cooking_detail: "procedure2")
        @procedure3 = create(:procedure, cuisine_id: @cuisine.id, cooking_detail: "procedure3")
        post managers_procedures_path, params: {
          procedure: {
            cooking_detail: "",
            cuisine_id: @cuisine.id
          }
        }
        expect(response.body).to include @cuisine.main_image.to_s
        expect(response.body).to include "説明文"
        expect(response.body).to include "procedure2"
        expect(response.body).to include "procedure3"
      end
    end
  end

  describe "GET /edit" do
    before do
      @procedure = create(:procedure)
    end

    it "リクエストが成功すること" do
      get edit_managers_procedure_path @procedure
      expect(response.status).to eq 200
    end

    it "editテンプレートが表示されること" do
      get edit_managers_procedure_path @procedure
      expect(response.body).to include "更新"
    end
  end

  describe "PATCH /update" do
    before do
      @procedure = create(:procedure, cooking_detail: "first_cooking_detail")
    end

    context "OK" do
      it "リクエストが成功すること" do
        put managers_procedure_path @procedure, params: {
          procedure: {
            cooking_detail: "valid_cooking_detail",
            cuisine_id: @procedure.cuisine_id
          }
        }
        expect(response.status).to eq 302
      end

      it "レコードの内容が更新されること" do
        expect do
          put managers_procedure_path @procedure, params: {
            procedure: {
              cooking_detail: "valid_cooking_detail",
              cuisine_id: @procedure.cuisine_id
            }
          }
        end.to change { Procedure.find_by(id: @procedure.id).cooking_detail }.from("first_cooking_detail").to("valid_cooking_detail")
      end

      it "newページへリダイレクトされること" do
        expect do
          put managers_procedure_path @procedure, params: {
            procedure: {
              cooking_detail: "valid_cooking_detail",
              cuisine_id: @procedure.cuisine_id
            }
          }
        end.to change { Procedure.find_by(id: @procedure.id).cooking_detail }.from("first_cooking_detail").to("valid_cooking_detail")
        follow_redirect!
        expect(response.body).to include "手順を追加する"
      end
    end

    context "NG" do
      it "リクエストが成功すること" do
        put managers_procedure_path @procedure, params: {
          procedure: {
            cooking_detail: "",
            cuisine_id: @procedure.cuisine_id
          }
        }
        expect(response.status).to eq 200
      end

      it "更新されないこと" do
        expect do
          put managers_procedure_path @procedure, params: {
            procedure: {
              cooking_detail: "",
              cuisine_id: @procedure.cuisine_id
            }
          }
        end.not_to change(Procedure.find_by(id: @procedure.id), :cooking_detail)
      end

      it "エラーメッセージが表示されること" do
        put managers_procedure_path @procedure, params: {
          procedure: {
            cooking_detail: "",
            cuisine_id: @procedure.cuisine_id
          }
        }
        expect(response.body).to include "手順を入力してください"
      end

      it "必要な情報が取得できること" do
        @procedure2 = create(:procedure, cuisine_id: @procedure.cuisine_id, cooking_detail: "procedure2")
        @procedure3 = create(:procedure, cuisine_id: @procedure.cuisine_id, cooking_detail: "procedure3")
        put managers_procedure_path @procedure, params: {
          procedure: {
            cooking_detail: "",
            cuisine_id: @procedure.cuisine_id
          }
        }
        expect(response.body).to include "更新"
        expect(response.body).to include @procedure.cuisine.main_image.to_s
        expect(response.body).to include "procedure2"
        expect(response.body).to include "procedure3"
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      @procedure = create(:procedure)
    end

    context "newテンプレートからリクエストを受けたとき" do
      it "リクエストが成功すること" do
        delete managers_procedure_path(@procedure, action_name: "new")
        expect(response.status).to eq 302
      end

      it "既存レコードが削除されること" do
        expect do
          delete managers_procedure_path(@procedure, action_name: "new")
        end.to change(Procedure, :count).by(-1)
      end

      it "newテンプレートへリダイレクトされること" do
        delete managers_procedure_path(@procedure, action_name: "new")
        follow_redirect!
        expect(response.body).to include "説明文"
      end
    end

    context "editテンプレートからリクエストを受けたとき" do
      it "リクエストが成功すること" do
        delete managers_procedure_path(@procedure, action_name: "edit")
        expect(response.status).to eq 302
      end

      it "既存レコードが削除されること" do
        expect do
          delete managers_procedure_path(@procedure, action_name: "edit")
        end.to change(Procedure, :count).by(-1)
      end

      it "newテンプレートへリダイレクトされること" do
        delete managers_procedure_path(@procedure, action_name: "edit")
        follow_redirect!
        expect(response.body).to include "説明文"
      end
    end

    context "cuisine/showページからリクエストを受けたとき" do
      it "リクエストが成功すること" do
        delete managers_procedure_path(@procedure, action_name: "show")
        expect(response.status).to eq 302
      end

      it "既存レコードが削除されること" do
        expect do
          delete managers_procedure_path(@procedure, action_name: "show")
        end.to change(Procedure, :count).by(-1)
      end

      it "cuisine/showページへリダイレクトされること" do
        delete managers_procedure_path(@procedure, action_name: "show")
        follow_redirect!
        expect(response.body).to include "概要"
      end
    end
  end
end
