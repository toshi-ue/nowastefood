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

RUN mkdir $APP_DIR
# ENV APP_DIR /webapp
WORKDIR $APP_DIR

ADD ./Gemfile $APP_DIR/Gemfile
ADD ./Gemfile.lock $APP_DIR/Gemfile.lock

RUN gem install bundler -v "1.17.3"
# RUN gem update --system &&\
# gem install bundler:$BUNDLER_VERSION
RUN bundle install --jobs=20

ADD . $APP_DIR
