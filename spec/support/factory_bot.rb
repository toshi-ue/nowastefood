RSpec.configure do |config|
  # FactoryBotの呼び出し簡略化
  #   テスト中に、FactoryBot.create(:user) ではなく、create(:user) と書けるようになる。
  config.include FactoryBot::Syntax::Methods

  # ここが原因?
  # springが原因でfactoryが正しく読み込まれないことを防ぐ
  config.before :all do
    FactoryBot.reload
  end
end
