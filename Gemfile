# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.7'

gem 'acts-as-taggable-on', '~> 8.0' # for not failing migration
gem 'bootsnap', require: false
gem 'bootstrap4-kaminari-views'
gem 'carrierwave'
gem 'cloudinary'
gem 'counter_culture'
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'discard'
gem 'dotenv-rails'
gem 'enum_help'
gem 'exception_notification'
gem 'faker'
gem 'flog'
gem 'fog-aws'
gem 'jbuilder'
gem 'kaminari'
gem 'mini_magick'
gem 'mysql2'
gem 'net-http'
gem 'puma'
gem 'puma_worker_killer'
gem 'rails', '~> 6.1.7'
gem 'rails-i18n'
gem 'ranked-model'
gem 'ransack'
gem 'seed-fu'
gem 'slack-notifier'
# https://qiita.com/sasakura_870/items/106484f88c857bd9563e#sprockets%E3%81%AE%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E3%82%92372%E3%81%AB%E4%B8%8B%E3%81%92%E3%82%8B
gem 'sprockets', '~> 3.7.2'
gem 'webpacker', '~> 5.0'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails-flog', require: 'flog'
  gem 'rspec-rails'
  gem 'stringio', '0.1.4'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  # # あとで見る
  # # https://qiita.com/YutoYasunaga/items/a8e56ef3c6a8ade06704#capistrano%E8%A8%AD%E5%AE%9A
  # gem 'capistrano'
  # gem 'capistrano3-puma'
  # gem 'capistrano-bundler'
  # gem 'capistrano-rails'
  # gem 'capistrano-rails-collection' # 例：　rails:rake:db:migrate　など
  # gem 'capistrano-rails-console' # cap production rails:c でコンソールにアクセスしたい場合
  # gem 'capistrano-rake' # 例：　cap production invoke:rake TASK=paperclip:refresh
  # gem 'capistrano-rbenv'
  # # TODO: あとでredisを使う
  # #   https://yutojp.com/articles/ruby-on-rails-sidekiq-no-doonyuu-tejun-rookaru-heroku-aws-ec-ni-docker-capistrano
  # # gem 'capistrano-sidekiq', require: false
  gem 'foreman'
  gem 'letter_opener_web'
  gem 'listen'
  gem 'rack-mini-profiler'
  gem 'rails-erd'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'solargraph'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'vcr'
  gem 'webdrivers'
  gem 'webmock'
end

# group :production do
#   # gem 'mini_racer', '0.6.3'
# end

# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# gem 'mini_racer', platforms: :ruby
# gem 'capistrano-rails', group: :development
# gem 'bcrypt', '~> 3.1.7'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
