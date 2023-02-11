# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Managers::Tops' do
  before do
    @manager = create(:manager)
    sign_in @manager
  end

  describe 'GET /dashboard' do
    context 'ログインしているとき' do
      it 'dashboardページが表示されること' do
        get managers_dashboard_path
        expect(response).to have_http_status :ok
        expect(response.body).to include 'Home'
      end
    end

    context 'ログインしていないとき' do
      it 'ログイン画面へリダイレクトされること' do
        sign_out @manager
        get managers_dashboard_path
        expect(response.status).to redirect_to(new_manager_session_path)
        follow_redirect!
        expect(response.body).to include 'ログイン'
      end
    end
  end
end
