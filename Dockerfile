
ARG RUBY_VERSION=2.7.7
FROM ruby:$RUBY_VERSION

ENV APP_DIR /webapp
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE yes
ENV DEBCONF_NOWARNINGS yes
ENV LANG C.UTF-8
ENV MY_BUNDLER_VERSION 2.1.4

WORKDIR $APP_DIR

# Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y --no-install-recommends \
  build-essential \
  graphviz \
  libpq-dev \
  nodejs \
  vim \
  yarn

COPY Gemfile Gemfile.lock /webapp/
COPY package.json yarn.lock /webapp/
RUN gem install bundler --no-document -v $MY_BUNDLER_VERSION && \
  bundle install
RUN yarn install --production --frozen-lockfile && yarn cache clean

COPY . $APP_DIR
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin//entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
