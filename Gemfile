source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap', '~> 4.4.1'
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'mysql2', '>= 0.3.18', '< 0.6.0'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.7'
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'bullet'
  gem 'letter_opener_web', group: :development
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rails', require: false
  gem 'solargraph'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'rubocop-rspec', require: false
  gem 'shoulda-matchers',
      git: 'https://github.com/thoughtbot/shoulda-matchers.git',
      branch: 'rails-5'
  gem 'simplecov'
  gem 'vcr'
  gem 'webdrivers'
  gem 'webmock'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# gem 'therubyracer', platforms: :ruby
# gem 'capistrano-rails', group: :development
# gem 'bcrypt', '~> 3.1.7'
# gem "rails_best_practices", require: false  , group: :development
# [flyerhzm/rails_best_practices: a code metric tool for rails projects](https://github.com/flyerhzm/rails_best_practices)
# [Ruby on Railsのコードをよりモダンにするために、Rails Best Practices入門・おすすめ設定 - Sider Blog](https://blog-ja.sideci.com/entry/2015/04/16/175508)
