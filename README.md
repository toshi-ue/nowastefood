# README

## 初期動作環境構築
<!--
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
-->
```bash
git clone ;
docker-compose build;

docker-compose run --rm web bundle install;
docker-compose run --rm web bundle update;
docker-compose run --rm web bin/yarn install;
docker-compose run --rm web rails db:create;
docker-compose run --rm web rails db:migrate;
docker-compose run --rm web rails db:seed_fu;
```
<!--
docker-compose run --rm --service-ports web bundle exec foreman start -f Procfile;
-->

## 問題点
- 問題点リスト
  - [0.問題点リスト · Issue #40 · toshi-ue/app_for_job_change](https://github.com/toshi-ue/app_for_job_change/issues/40)
    - 優先(動作しないため作業を進めることができない)

- 質問リスト
  - [0.調査リスト · Issue #55 · toshi-ue/app_for_job_change](https://github.com/toshi-ue/app_for_job_change/issues/55)

現状としては以上になります。
よろしくお願いいたします。
<!--
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

-->
