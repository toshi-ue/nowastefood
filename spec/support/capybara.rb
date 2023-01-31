# frozen_string_literal: true

require 'capybara/rspec'
require 'selenium-webdriver'
require 'vcr'

Capybara.register_driver :remote_chrome do |app|
  url = "http://chrome:4444/wd/hub"
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    "chromeOptions" => {
      args: [
        "no-sandbox",
        # ブラウザで動作確認したい場合は"headless"をコメントアウト
        "headless",
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

  config.before(:each, js: true, type: :system) do
    driven_by :remote_chrome
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 3000
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
end
