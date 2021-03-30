ARG RUBY_VERSION=2.7.2
FROM ruby:$RUBY_VERSION

ENV APP_DIR /webapp
ENV BUNDLER_VERSION 2.1.4
ENV LANG C.UTF-8
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE yes
ENV DEBCONF_NOWARNINGS yes
EXPOSE 3000

# Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  vim \
  nodejs

# yarn
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn

RUN bundle config --local jobs 4
RUN bundle config set --local path 'vendor/bundle'

RUN gem install bundler -v ${BUNDLER_VERSION} && \
  bundle install


RUN mkdir $APP_DIR
# ENV APP_DIR /webapp
WORKDIR $APP_DIR
