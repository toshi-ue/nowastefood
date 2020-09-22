require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  before do
    @user = create(:user)
    sign_in @user
    get root_path
  end

  describe "GET /index" do
    context 'ログインしているとき' do
      it 'リクエストが成功すること' do
        get favorites_index_path
        expect(response.status).to eq 200
      end

      it 'indexページで表示されること' do
        cuisine = create(:cuisine, name: "料理1")
        cuisine2 = create(:cuisine, name: "料理2")
        favorite = create(:favorite, user_id: @user.id, cuisine_id: cuisine.id)
        favorite2 = create(:favorite, user_id: @user.id, cuisine_id: cuisine2.id)
        get favorites_index_path
        expect(response.body).to include "料理1"
        expect(response.body).to include "料理2"
      end
    end

    context 'ログインしていないとき' do
      it 'ログインページへリダイレクトすること' do
        sign_out @user
        get favorites_index_path
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response.body).to include "メールアドレス"
      end
    end
  end

  describe "POST /create" do
    # TODO: テストを追加する
    context 'ログインしているとき' do
      # テストがパスしない
      it '登録できること' do
        cuisine = create(:cuisine)
        favorite = build(:favorite)
        expect{
          post cuisine_favorites_path(cuisine.id, cuisine.id),
                params: { favorite: attributes_for(:favorite, user_id: @user.id, cuisine_id: cuisine.id)}
        }.to change{Favorite.count}.by(1)
      end
      # TODO: ajaxで実装したいため保留中
      it 'cuisine/showページへリダイレクトすること'
    end

    context 'ログインしていないとき' do
      it 'ログインページへリダイレクトすること' do
        cuisine = create(:cuisine)
        sign_out @user
        post cuisine_favorites_path(cuisine.id)
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response.body).to include "メールアドレス"
      end
    end
  end

  describe "DELETE /destroy" do
    context 'ログインしているとき' do
      it '削除できること'
      # TODO: ajaxで実装したいため保留中
      it 'cuisine/showページへリダイレクトすること'
    end

    context 'ログインしていないとき' do
      # FIXME:
      #   テストをパスしない
      #    ログインしていない場合の処理はどのように書けば良いのか
      it 'ログインページへリダイレクトすること' do
        cuisine = create(:cuisine)
        favorite = create(:favorite)
        sign_out @user
        delete cuisine_favorite_path(cuisine.id, cuisine.id)
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
        follow_redirect!
        expect(response.body).to include "メールアドレス"
      end
    end
  end
end
