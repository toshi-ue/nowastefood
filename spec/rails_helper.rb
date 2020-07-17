require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'simplecov'
require 'capybara/rspec'
require 'database_cleaner'
require 'selenium-webdriver'
require 'factory_bot'
require 'shoulda-matchers'
require 'vcr'
require 'spec_helper'
require 'rspec/rails'

# spec/support以下に、いろいろファイルを置けるようになる
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.use_transactional_fixtures = true
  # config.filter_gems_from_backtrace("gem name")
  config.before(:suite) do
    # DBを綺麗にする手段を指定、トランザクションを張ってrollbackするように指定
    DatabaseCleaner.strategy = :transaction
    # truncate table文を実行し、レコードを消す
    DatabaseCleaner.clean_with(:truncation)
    SeedFu.seed
  end

  # exampleが始まるごとに実行
  config.before do
    # strategyがtransactionなので、トランザクションを張る
    DatabaseCleaner.start
  end

  # exampleが終わるごとに実行
  config.after do
    # strategyがtransactionなので、rollbackする
    DatabaseCleaner.clean
  end
  # request_specを使用する場合
  # config.include RequestSpecHelper, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :request
  # system_specを使用する場合
  config.include Devise::Test::IntegrationHelpers, type: :system

  # Shoulda::Matchers.configure do |config|
  #   config.integrate do |with|
  #     with.test_framework :rspec
  #     with.library :rails
  #   end
  # end
end

# config.before(:each, type: :feature) do
#   driven_by :selenium_chrome
# end
