<!--
# README

## 初期動作環境構築

git clone後に下記コマンドを実行すれば動作確認できると思います。<br />

yarn・jQueryなどのfrontendはほぼ初心者ですのでコマンドの抜け等がありましたら申し訳ありません。<br>

```bash
docker-compose build;
docker-compose run web rails db:create;
docker-compose run web rails db:migrate;
# 初期データ作成(seed_fuを使用)
docker-compose run web rails db:seed_fu;
docker-compose run web rails db:seed_fu;
docker-compose up -d && docker attach app_for_job_change_web_1;
```

```bash
git clone ;
docker-compose build;

docker-compose run --rm web bundle install;
docker-compose run --rm web bundle update;
docker-compose run --rm web bin/yarn install;
docker-compose run --rm web rails db:create;
docker-compose run --rm web rails db:migrate;

# 既存DBからデータを db/afixtures/ にバックアップ
docker-compose run --rm web rails seed_fu_gen:all;
# 投入用のseedデータを作成
docker-compose run --rm web rails seed_fu_all_datas:all;
# seedデータの main_imageカラムの設定を変更
docw rails change_properties_to_adapt_seed_data:all;
# データをseedする
docker-compose run --rm web rails db:seed_fu;
```

## 問題点
- 問題点リスト
  - [0.問題点リスト · Issue #40 · toshi-ue/app_for_job_change](https://github.com/toshi-ue/app_for_job_change/issues/40)
    - 優先(動作しないため作業を進めることができない)

- 質問リスト
  - [0.調査リスト · Issue #55 · toshi-ue/app_for_job_change](https://github.com/toshi-ue/app_for_job_change/issues/55)

現状としては以上になります。
よろしくお願いいたします。

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## 参考にしたサイト
### HTML・CSS
- カード画像を中央の位置でトリミング
  - [1行追加でOK！CSSだけで画像をトリミングできる「object-fit」プロパティー | Webクリエイターボックス](https://www.webcreatorbox.com/tech/object-fit)

### 機能
- 関連レコードのカウントをDBに保存する
  - 
- 画像スライダー機能
  - [swiper/API.md at Swiper5 · nolimits4web/swiper](https://github.com/nolimits4web/swiper/blob/Swiper5/API.md)
  - [レスポンシブ対応でjQuery不要の高機能スライダー「Swiper」 | Will Style Inc.｜神戸にあるウェブ制作会社](https://www.willstyle.co.jp/blog/724/)
  - [Swiper.jsの使い方「レスポンシブ等の具体例」とオプション解説](https://stand-4u.com/web/javascript/swiper.html#%EF%BC%91%E7%94%BB%E9%9D%A2%E3%81%AB%E8%A4%87%E6%95%B0%E6%9E%9A%E8%A1%A8%E7%A4%BA%E3%81%99%E3%82%8B%E3%82%AB%E3%83%AB%E3%83%BC%E3%82%BB%E3%83%AB%E3%82%BF%E3%82%A4%E3%83%97%E3%81%AB%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95)
  - [Swiperのオプションを一覧でご紹介します | WEBコーダーBLOG](https://coder-memo.com/swiper-option/)
  - [【Swiper.js】複数のスライダーを同じページに設置する方法｜KaitoTakase｜note](https://note.com/kaito_takase/n/n0c26570be394)
  - [スライダープラグイン Swiper（v5）の使い方 / Web Design Leaves](https://www.webdesignleaves.com/pr/plugins/swiper_js.html)
  - [【JavaScript】スライダープラグイン「swiper.js」で同じオプション設定のスライダーを同一ページで複数設置する | 何もないけどヨロシク。](https://nanimonaikedo.jp/markup/1682/)
  - [【Rails5】「Swiper」を使ってスライダー、カルーセルを作る方法 - Qiita](https://qiita.com/emincoring/items/18d07d0aec5d9836227c)
- タグ機能
  - [mbleigh/acts-as-taggable-on: A tagging plugin for Rails applications that allows for custom tagging along dynamic contexts.](https://github.com/mbleigh/acts-as-taggable-on)
  - [erb - How to count the amount of times a tag has been used with ActsAsTaggableOn rails - Stack Overflow](https://stackoverflow.com/questions/38530218/how-to-count-the-amount-of-times-a-tag-has-been-used-with-actsastaggableon-rails)
- 補完機能
  - [【JavaScript】Select2でプルダウンをおしゃれにする【ライブラリ】 - Qiita](https://qiita.com/mtanabe/items/c324a2d4a8de8d1595e4)

ポートフォリオの内容

ポートフォリオを作った経緯

機能を画面共有しながら紹介する


苦労した点
技術的な側面

サービス的な側面

現在の問題点
-->


## サービス概要

自宅にある食材のフードロスを減らすことを目的としたレシピサイトサービス

## サイトURL
[サービス名未定？](https://nowastefood.tk/)


## ターゲット層

- 主婦
- 一人暮らし、単身赴任中の自炊をしている方

## ユーザーが抱える問題

昨今のコロナの影響により、外食を控えて自宅で食べることが多くなりました。<br>
<!-- 料理をする際にはまず自宅にある食材を消費することを前提に考えますが、 -->
自炊・料理をされている方には問題があります。
- 自宅の食材の消費期限はいつなのかを把握しておかなければいけない
- 消費期限間近の食材からメニューを探すのに時間がかかる

## 解決方法
考えられる解決方法は以下になります

- 食材を登録すれば消費期限が確認できるようにするサイトを作る
- 登録されている食材をもとに

## 現状の問題点
### 技術的側面

- 404, 500エラーが発生した時にNginxの404、500ページが表示される(Railsの`public`配下の404,500ページが参照されない)
- associationがうまくいっていない

## 今後やっていきたいこと

- vueを導入する
- エラーの撲滅
- メール送受信をSendGridを使用して動作させる
- contactにuserを紐づける

## ER図
![10_46_25](https://user-images.githubusercontent.com/46378023/138380342-abc2fb89-fd3c-4068-b4de-3dcdf42dad0b.jpg)

## インフラ図
![infra](https://user-images.githubusercontent.com/46378023/138411974-f3179342-f183-4e47-90b4-47c2f92fe892.png)
<!--
参考URL

[無料！かつ最短？で Ruby on Rails on Docker on AWS のアプリを公開するぞ。 - Qiita](https://qiita.com/at-946/items/1e8acea19cc0b9f31b98#5-1-acm%E3%81%A7ssl%E8%A8%BC%E6%98%8E%E6%9B%B8%E3%82%92%E7%99%BA%E8%A1%8C%E3%81%99%E3%82%8B)
[ryota1116/zero_calorie: 全ての食べ物を0kcalにするカロリー管理アプリ](https://github.com/ryota1116/zero_calorie)
[30代未経験からRails, AWS, Docker, CircleCIを使って減量アプリを作りました - Qiita](https://qiita.com/naota7118/items/d641eae70dd65412a00b)
[Rails+PostgreSQL+Docker+AWSで作成したポートフォリオの概要 - いわりょのBlog](https://ryo10leo.hatenablog.com/entry/2020/02/02/204150)
[daichi5/kotonoha: Rails+Docker+AWS](https://github.com/daichi5/kotonoha)
[開発環境インフラを ECS 移行している話 - Akatsuki Hackers Lab | 株式会社アカツキ（Akatsuki Inc.)](https://hackerslab.aktsk.jp/migrating-infrastructure-to-ecs)
[【個人開発】性格診断でお酒と出会う新サービス、「さけぐらむ🍶」リリースしました！🎉🎉 - Qiita](https://qiita.com/watsumi_/items/cd77a0f2ec3630d550f8)
[naka-no-mura/best_gifter](https://github.com/naka-no-mura/best_gifter)
[kazu-2020/arrangy](https://github.com/kazu-2020/arrangy)
-->
