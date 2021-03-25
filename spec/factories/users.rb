FactoryBot.define do
  factory :user do
    nickname { Faker::Name.first_name }
    sequence(:email) { |n| "user#{n + 2}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    profile_image { Rack::Test::UploadedFile.new("#{Rails.root}/app/assets/images/test.jpg", "image/jpeg") }
    confirmation_sent_at { Time.zone.today - 2.days }
    confirmed_at { Time.zone.today - 1.day }
  end
end
