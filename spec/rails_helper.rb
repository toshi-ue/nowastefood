require 'spec_helper'
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'simplecov'
require 'capybara/rspec'
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
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.use_transactional_fixtures = true
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
