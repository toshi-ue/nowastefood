require 'rails_helper'

RSpec.describe "Foodcategories", type: :system do
  # # 管理者アカウントを作成、ログインする
  # before do
  #   manager = FactoryBot.create(:manager)
  #   visit root_path
  #   click_link "管理者としてログイン"
  #   fill_in "メールアドレス", with: manager.email
  #   fill_in "パスワード", with: manager.password
  #   click_button "ログイン"
  #   # expect(response).to redirect_to root_path
  #   expect(page).to have_selector 'div.alert-success', text: 'ログインしました。'
  #   expect(page).to have_current_path root_path, ignore_query: true
  # end

  # context "when 管理者としてログインしている時" do
  #   it "料理区分のインスタンスを作成できること" do
  # expect{
  #   visit managers_foodcategories_path
  #   expect(page).to have_current_path managers_foodcategories_path, ignore_query: true
  #   visit new_managers_foodcategory_path
  #   foodcategory = FactoryBot.create(:foodcategory)
  # }

  #  do
  #   click_button "登録する"
  # end.to change(Foodcategory, :count).by(1)
  # end

  # it "" do
  # end
  # end
  # "サインイン後に'ログインしました'が表示する"
  # it "Show logged in after signing in" do
  # save_and_open_page

  # save_and_open_page
  # expect(page).to have_content 'ログインしました。'
  # expect(page).to have_selector 'div.alert-success', text: 'ログインしました。'
  # expect(page).to have_selector 'p.notice', text: 'ログインしました。'
  # end

  # it "ログアウト後に'ログアウトしました'を表示する"
  # 管理者作成
  # トップページに行く
  # ログインする
  #   メールアドレスを入力
  #   パスワードを入力
  #   ログインをクリック
  # フラッシュメッセージが表示される

  # it "管理者はサインイン後にレコードを作成する"
  # 管理者作成
  # トップページに行く
  # ログインする
  #   メールアドレスを入力
  #   パスワードを入力
  #   ログインをクリック
  # フラッシュメッセージが表示される
  # 画面遷移ボタン(リンク)をクリックする(該当するactinへfoodcategories#index)
  # 追加するをクリックする
  # 食材区分名のフォームに値を入力
  # 登録するボタンをクリック

  # it "管理者はサインイン後にレコードを変更する"
  # 管理者作成
  # トップページに行く
  # ログインする
  #   メールアドレスを入力
  #   パスワードを入力
  #   ログインをクリック
  # フラッシュメッセージが表示される

  # it "管理者はサインイン後にレコードを削除する"
  # 管理者作成
  # トップページに行く
  # ログインする
  #   メールアドレスを入力
  #   パスワードを入力
  #   ログインをクリック
  # フラッシュメッセージが表示される

  # request_specで
  # it "200を返す"

  # it "成功時のjsonレスポンスを返す"

  # it "404 Bad Requestを返す"
end
