require 'rails_helper'

RSpec.describe "Managers::Rawmaterials", type: :request do
  before do
    @manager = create(:manager)
    sign_in @manager
  end

  describe "GET /index" do
    context "管理者でログインしているとき" do
      it "indexページが表示されること" do
        @rawmaterial1 = create(:rawmaterial)
        @rawmaterial2 = create(:rawmaterial)
        get managers_rawmaterials_path
        expect(response.status).to eq 200
        expect(response.body).to include @rawmaterial1.name
        expect(response.body).to include @rawmaterial2.name
      end
    end

    context "管理者でログインしていないとき" do
      it "ログイン画面へリダイレクトされること" do
        sign_out @manager
        get managers_rawmaterials_path
        expect(response).to redirect_to(new_manager_session_path)
      end
    end
  end

  describe "GET /new" do
    context "管理者でログインしているとき" do
      it "newページが表示されること" do
        get new_managers_rawmaterial_path
        expect(response.status).to eq 200
        expect(response.body).to include "原材料を追加"
      end
    end

    context "管理者でログインしていないとき" do
      it "ログイン画面へリダイレクトされること" do
        sign_out @manager
        get new_managers_rawmaterial_path
        expect(response.status).to redirect_to(new_manager_session_path)
        follow_redirect!
        expect(response.body).to include "ログイン"
      end
    end
  end

  describe "GET /edit" do
    before do
      @rawmaterial = create(:rawmaterial)
    end

    context "管理者でログインしているとき" do
      it "editページが表示されること" do
        get edit_managers_rawmaterial_path @rawmaterial
        expect(response.status).to eq 200
        expect(response.body).to include @rawmaterial.name
      end
    end

    context "管理者でログインしていないとき" do
      it "ログイン画面へリダイレクトされること" do
        sign_out @manager
        get edit_managers_rawmaterial_path @rawmaterial
        expect(response.status).to redirect_to(new_manager_session_path)
        follow_redirect!
        expect(response.body).to include "ログイン"
      end
    end
  end

  describe "PATCH #update" do
    it "更新されること" do
      @rawmaterial = create(:rawmaterial, name: "原材料")
      expect do
        patch managers_rawmaterial_path @rawmaterial, params: {
          rawmaterial: {
            name: "サンプルの原材料名",
            hiragana: "さんぷるのげんざいりょうめい",
            unit_id: @rawmaterial.unit_id,
            foodcategory_id: @rawmaterial.foodcategory_id,
            foodstuffs_count: @rawmaterial.foodstuffs_count
          }
        }
      end.to change { Rawmaterial.find_by(id: @rawmaterial.id).name }.from("原材料").to("サンプルの原材料名")
      expect(response.status).to eq 302
      expect(response).to redirect_to(managers_rawmaterials_path)
    end
  end

  describe "DELETE /destroy" do
    it "削除できること" do
      @rawmaterial = create(:rawmaterial)
      expect do
        delete managers_rawmaterial_path @rawmaterial
      end.to change(Rawmaterial, :count).by(-1)
      expect(response.status).to eq 302
      expect(response).to redirect_to(managers_rawmaterials_path)
    end
  end
end
