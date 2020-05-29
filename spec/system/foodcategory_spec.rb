require 'rails_helper'

RSpec.describe "Foodcategories", type: :system, js: true do
  # pending "add some scenarios (or delete) #{__FILE__}"
  scenario "サインアップ後に'ログインしました'が表示する" do
  end

  scenario "サインイン後に'ログインしました'が表示する" do
    # 管理者作成
    manager = FactoryBot.create(:manager)
    # manager.confirm
    # トップページに行く
    visit root_path
    # 管理者ログイン画面へ
    click_link "管理者としてログイン"
    #   メールアドレスを入力
    fill_in "メールアドレス", with: manager.email
    #   パスワードを入力
    fill_in "パスワード", with: manager.password
    # save_and_open_page
    #   ログインをクリック
    click_button "ログイン"
    # save_and_open_page
    # フラッシュメッセージが表示される
    # expect(page).to have_content 'ログインしました。'
    expect(page).to have_selector 'p.notice', text: 'ログインしました。'
  end

  it "ログアウト後に'ログアウトしました'を表示する"
  # 管理者作成
  # トップページに行く
  # ログインする
  #   メールアドレスを入力
  #   パスワードを入力
  #   ログインをクリック
  # フラッシュメッセージが表示される

  it "管理者はサインイン後にレコードを作成する"
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

  it "管理者はサインイン後にレコードを変更する"
  # 管理者作成
  # トップページに行く
  # ログインする
  #   メールアドレスを入力
  #   パスワードを入力
  #   ログインをクリック
  # フラッシュメッセージが表示される

  it "管理者はサインイン後にレコードを削除する"
  # 管理者作成
  # トップページに行く
  # ログインする
  #   メールアドレスを入力
  #   パスワードを入力
  #   ログインをクリック
  # フラッシュメッセージが表示される

  # request_specで
  it "200を返す"

  it "成功時のjsonレスポンスを返す"

  it "404 Bad Requestを返す"
end
