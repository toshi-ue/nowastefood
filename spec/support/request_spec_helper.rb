# [Rails + RSpec + Capybara で Devise での認証ログインが必要なインテグレーションテスト（RequestSpec）を行う | EasyRamble](https://easyramble.com/request-spec-on-devise-login.html)
# [RequestSpecでDeviseを使ったユーザーでログインさせる | 自転車で通勤しましょ♪ブログ](http://319ring.net/blog/archives/2052/)
# [rspec devise sign_in override - Google 検索](https://www.google.com/search?ei=NX7lXviAMaiUr7wPzr6-WA&q=rspec+devise+sign_in+override&oq=rspec+devise+sign_in+override&gs_lcp=CgZwc3ktYWIQAzIFCAAQzQI6BQghEKABOgQIIRAVUPabA1jDsQNgjrMDaABwAHgAgAGQAYgBlwiSAQMxLjiYAQCgAQGqAQdnd3Mtd2l6&sclient=psy-ab&ved=0ahUKEwi478HIlIDqAhUoyosBHU6fDwsQ4dUDCAw&uact=5)
# [How To: sign in and out a user in Request type specs (specs tagged with type: :request) · heartcombo/devise Wiki · GitHub](https://github.com/heartcombo/devise/wiki/How-To:-sign-in-and-out-a-user-in-Request-type-specs-%28specs-tagged-with-type:-:request%29)
# [Deviseのテストを行う際の注意 | 目指せ、スーパーエンジニア](https://hirocorpblog.com/post-112/)

module RequestSpecHelper
  # include Warden::Test::Helpers

  # def self.included(base)
  #   base.before { Warden.test_mode! }
  #   base.after { Warden.test_reset! }
  # end

  # def sign_in(resource)
  #   login_as(resource, scope: warden_scope(resource))
  # end

  # def sign_out(resource)
  #   logout(warden_scope(resource))
  # end

  # private

  # def warden_scope(resource)
  #   resource.class.name.underscore.to_sym
  # end
end

# Rspec.configure do |config|
#   # config.include LoginSupportByDevise
#   config.include LoginSupport
# end
