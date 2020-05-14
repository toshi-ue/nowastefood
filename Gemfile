# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# gem 'auto_strip_attributes'
# gem 'counter_culture'
gem 'devise'
# gem 'discard'
gem 'dotenv-rails'
gem 'gimei'
gem 'jbuilder', '~> 2.5'
gem 'jp_prefecture'
gem 'jquery-rails'
gem 'kaminari'
gem 'mysql2', '>= 0.3.18', '< 0.6.0'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.7'
gem 'ransack'
gem 'sass-rails', '~> 5.0'
gem 'seed-fu'
gem 'slim-rails'
gem 'uglifier', '>= 1.3.0'


group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capistrano'
  # gem 'capistrano-bundler'
  # gem 'capistrano-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  # gem 'capistrano-rbenv'
  # gem 'capistrano3-unicorn'
  gem 'pry-rails'
  gem 'rspec-rails'
  # gem 'capistrano3-puma'
  gem 'rails-controller-testing'
  # gem'selenium-webdriver'
  # gem'chromedriver-helper
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem "guard", require: false
  gem "guard-livereload", require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'solargraph'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
