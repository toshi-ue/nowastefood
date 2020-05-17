RSpec.configure do |config|
  # 単純なブラウザ操作だけのテストで使用する(高速)
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  # 複雑なブラウザ操作(jsが必要)があるテストで使用する(jsが実行可能)
  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end
