# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    # FIXME: rubyのライブラリ open-uri をrequireしてダミー画像を登録できるようにしたい
    # require "open-uri"
    faker_name = Faker::Name.first_name
    # image_file = open(Faker::Avatar.image(slug: faker_name, size: "150x150", format: "jpg"))
    nickname { faker_name }
    sequence(:email) { |n| "user#{n + 2}@example.com" }
    # sequence(:profile_image) { image_file }
    password { 'password' }
    password_confirmation { 'password' }
    confirmation_sent_at { Time.zone.today - 2.days }
    confirmed_at { Time.zone.today - 1.day }
    # image_file.close
    trait :with_avatar do
      profile_image { Rack::Test::UploadedFile.new("#{Rails.root}/app/javascript/images/test.jpg", 'image/jpeg') }
    end
  end
end
