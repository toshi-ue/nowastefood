FactoryBot.define do
  factory :user do
    nickname { Gimei.unique.name.kanji }
    sequence(:email) { |n| "heascook_user#{n + 2}@ahk.jp" }
    password { 'password' }
    password_confirmation { 'password' }
    profile_image { Faker::Avatar.image(slug: "my-own-slug", size: "50x50") }
    confirmation_sent_at { Time.zone.today - 2.days }
    confirmed_at { Time.zone.today - 1.day }
  end
end
