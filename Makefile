# https://github.com/belion-freee/quickstart/blob/master/qs
# [- 自動化のためのGNU Make入門講座 - Makefileの基本：ルール](http://objectclub.jp/community/memorial/homepage3.nifty.com/masarl/article/gnu-make/rule.html)
# [Makefileの解説](http://omilab.naist.jp/~mukaigawa/misc/Makefile.html)
# [いまさら人に聞けないmake入門 - UUUMエンジニアブログ](https://system.blog.uuum.jp/entry/make#%E8%87%AA%E5%8B%95%E5%A4%89%E6%95%B0)
# [Makefileで外部プログラムの実行結果を変数に取り込む - Qiita](https://qiita.com/vega77/items/5206c397258b5b372fc4)
# [MakefileのPHONYで便利コマンドを書く - なるぽのブログ](https://yu-nix.com/archives/makefile-phony/)
# [Makefile の .PHONY ターゲットは明記しておく癖をつけておく | Advanced Insight](https://advancedinsight.jp/using_phony_target_for_makefile/)

# docker_not_installed:
# 		@echo "Please install Docker before run this command."
#     exit 2

# [意外なところで使えるMakefile - 無気力生活 (ノ ´ω｀)ノ ~゜](https://gdgd-shinoyu.hatenablog.com/entry/2019/10/22/163601)
init:
		@make docker/build-no-cache
		@make rails/webpacker-compile
		@make rails/db-setup-development

# https://www.tom08.net/2019-01-17-233258/#:~:text=Pocket-,makefile,-%E3%82%92%E6%9B%B8%E3%81%84
docker/attach-web:
		docker compose up -d
		docker attach (docker compose ps -q web)

docker/build-no-cache:
		docker compose build --no-cache

docker/remove-all:
		docker compose down --rmi all --volumes --remove-orphans

heroku/deploy:
		git push heroku `git rev-parse --abbrev-ref HEAD`:main

# https://qiita.com/RyochanUedasan/items/d447cbf2733e389994bb
heroku/app-restart:
		heroku restart

# https://teratail.com/questions/111988
heroku/app-in:
		heroku run bash

heroku/logs--tail:
		heroku logs --tail

heroku/puma-restart:
		heroku run bundle exec pumactl restart

rails/bundle:
		docker compose run --no-deps --rm web bundle install -j`getconf _NPROCESSORS_ONLN`

rails/db-drop:
		docker compose run --rm web rails db:environment:set RAILS_ENV=development
		docker compose run --rm web rails db:drop

rails/db-setup-development:
		docker compose run --rm web rails db:create
		docker compose run --rm web rails db:migrate
		docker compose run --rm web rails db:seed_fu

rails/db-reset:
		docker compose run --rm web rails db:environment:set RAILS_ENV=development
		docker compose run --rm web rails db:migrate:reset
		@make rails/db-setup-development

rails/erb-lint:
		docker compose run --no-deps --rm web erblint --lint-all
rails/erb-lint-force:
		docker compose run --no-deps --rm web erblint --lint-all -a

rails/webpacker-tmp-clear:
		docker compose run --no-deps --rm web bundle exec rails tmp:clear

rails/webpacker-compile:
		docker compose run --no-deps --rm web bundle exec rails webpacker:compile

rspec:
		docker compose run --rm web rspec

test/rspec_local_circle_ci:
		circleci config process .circleci/config.yml > process.yml
		circleci local execute -c process.yml rspec

yarn/install:
		docker compose run --no-deps --rm web yarn install


ec:
		@echo $(DC)
