source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.7'
gem 'mysql2', '>= 0.3.18', '< 0.6.0'
gem 'puma', '~> 3.7'
gem 'sassc-rails'
gem 'bootstrap', '~> 4.4.1'
gem 'jquery-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# gem 'therubyracer', platforms: :ruby
gem 'devise'
gem 'jbuilder', '~> 2.5'
# gem 'bcrypt', '~> 3.1.7'
gem 'slim-rails'
gem 'devise-i18n'
gem 'devise-i18n-views'
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'bullet'
  gem 'letter_opener_web', group:  :development
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'webdrivers'
  gem 'shoulda-matchers',
    git: 'https://github.com/thoughtbot/shoulda-matchers.git',
    branch: 'rails-5'
  gem 'vcr'
  gem 'webmock'
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
