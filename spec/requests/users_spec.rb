# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users' do
  before do
    @user = create(:user)
    sign_in @user
  end

  describe 'GET /show' do
    it 'プロフィール画面が表示されること' do
      get user_profile_path
      expect(response).to have_http_status :ok
      expect(response.body).to include 'ユーザー情報'
    end
  end

  describe 'put /update_profile' do
    it 'ユーザー情報が更新されること' do
      @user.nickname = 'aaa'
      @user.default_serving_count = 4
      @user.save!
      expect do
        put update_profile_path(@user), params: {
          user: {
            nickname: 'bbb',
            profile_image: Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/images/test.jpg", 'image/jpeg'),
            default_serving_count: 2
          }
        }
      end.to change { User.find_by(id: @user.id).nickname }.from('aaa').to('bbb')
      expect(response).to have_http_status :found
      expect(response).to redirect_to(user_profile_path)
      follow_redirect!
      expect(response.body).to include 'bbb'
    end
  end
end
