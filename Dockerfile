ARG RUBY_VERSION=2.5.7
# ARG BUNDLER_VERSION=1.17.3

FROM ruby:$RUBY_VERSION

# 絵文字対応
ENV LANG C.UTF-8
# 作業ディレクトリ
ENV APP_DIR /webapp
# [Dockerfileの”ENV”と”ARG”と”環境変数”について | レコチョクのエンジニアブログ](https://techblog.recochoku.jp/1979)

# remove debconf warning. debconf is a configuration system for Debian packages.
ENV DEBCONF_NOWARNINGS yes

# remove apt-key warning like 'Warning: apt-key output should not be parsed (stdout is not a terminal)'
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE yes

# make the rails server port public
EXPOSE 3000

RUN apt-get update -qq && \
  # 各種インストール
  apt-get install -y --no-install-recommends \
  # ビルドツールを提供しているパッケージ
  build-essential \
  libpq-dev \
  # vim
  vim \
  # nodejs
  nodejs

# yarn(パッケージ管理ツール)インストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN mkdir $APP_DIR
# ENV APP_DIR /webapp
WORKDIR $APP_DIR
