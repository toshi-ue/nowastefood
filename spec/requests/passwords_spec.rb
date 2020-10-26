require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  before do
    user = create(:user)
    sign_in user
    get root_path
  end

  describe "GET /update" do
    it "パスワードが変更できること" do
      put password_path, params: {
        user: {
          password: "password1",
          password_confirmation: "password1",
          current_password: "password"
        }
      }
      expect(response.status).to eq 302
      follow_redirect!
      expect(response.body).to include "変更"
    end

    it "パスワードが変更できないこと" do
      put password_path, params: {
        user: {
          password: "pa",
          password_confirmation: "pass",
          current_password: "pas"
        }
      }
      expect(response.status).to eq 200
      expect(response.body).to include "一致しません"
      expect(response.body).to include "不正な値です"
      expect(response.body).to include "パスワードの変更"
    end
  end
end
