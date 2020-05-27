# RSpec.configure do |config|
#   # 単純なブラウザ操作だけのテストで使用する(高速)
#   config.before(:each, type: :system) do
#     driven_by :rack_test
#   end

#   # 複雑なブラウザ操作(jsが必要)があるテストで使用する(jsが実行可能)
#   config.before(:each, type: :system, js: true) do
#     driven_by :selenium_chrome_headless
#   end
# end

require 'capybara/rspec'
require 'selenium-webdriver'
require 'vcr'

# Capybara.register_driver :selenium_chrome_headless do |app|
#   options = ::Selenium::WebDriver::Chrome::Options.new

#   options.add_argument('--headless')
#   options.add_argument('--no-sandbox')
#   options.add_argument('--disable-dev-shm-usage')
#   options.add_argument('--window-size=1400,1400')

#   driver = Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
# end

# Capybara.javascript_driver = :selenium_chrome_headless

# RSpec.configure do |config|
#   config.before(:each, type: :system) do
#     driven_by :rack_test
#   end

#   config.before(:each, type: :system, js: true) do
#     driven_by :selenium_chrome_headless
#   end
# end

Capybara.register_driver :remote_chrome do |app|
  url = "http://chrome:4444/wd/hub"
  caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    "goog:chromeOptions" => {
      "args" => [
        "no-sandbox",
        # "headless",
        "disable-gpu",
        "window-size=1680,1050"
      ]
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: caps)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :remote_chrome
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    # Capybara.server_host = '0.0.0.0'
    Capybara.server_port = 3000
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
  # ~~~
end
