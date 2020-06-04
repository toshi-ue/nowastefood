ARG RUBY_VERSION=2.5.7
# ARG BUNDLER_VERSION=1.17.3

FROM ruby:$RUBY_VERSION

# 絵文字対応
ENV LANG C.UTF-8
# 作業ディレクトリ
ENV APP_DIR /webapp
# [Dockerfileの”ENV”と”ARG”と”環境変数”について | レコチョクのエンジニアブログ](https://techblog.recochoku.jp/1979)

RUN apt-get update -qq && \
  # 各種インストール
  apt-get install -y --no-install-recommends \
  # vim
  vim \
  # nodejs
  nodejs \
  # ビルドツールを提供しているパッケージ
  build-essential && \
  #  libpq-dev
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN mkdir $APP_DIR
# ENV APP_DIR /webapp
WORKDIR $APP_DIR

ADD ./Gemfile $APP_DIR/Gemfile
ADD ./Gemfile.lock $APP_DIR/Gemfile.lock

RUN gem install bundler -v "1.17.3"
# RUN gem update --system &&\
# gem install bundler:$BUNDLER_VERSION
RUN bundle install --jobs=100

ADD ./package.json $APP_DIR/package.json
ADD ./yarn.lock $APP_DIR/yarn.lock
RUN yarn install

ADD . $APP_DIR
