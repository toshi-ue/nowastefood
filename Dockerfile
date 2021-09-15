
ARG RUBY_VERSION=2.7.3
FROM ruby:$RUBY_VERSION

ENV APP_DIR /webapp
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE yes
ENV BUNDLE_JOBS 4
ENV BUNDLE_PATH vendor/bundle
ENV LANG C.UTF-8
ENV MY_BUNDLER_VERSION 2.1.4


ENV DEBCONF_NOWARNINGS yes

RUN mkdir $APP_DIR
WORKDIR $APP_DIR

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


# COPY Gemfile Gemfile.lock /webapp/
COPY Gemfile /webapp
COPY package.json yarn.lock /webapp/
RUN gem install bundler --no-document -v $MY_BUNDLER_VERSION && \
  bundle install
RUN yarn install --production --frozen-lockfile && yarn cache clean

COPY . $APP_DIR

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
