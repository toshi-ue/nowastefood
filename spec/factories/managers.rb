FactoryBot.define do
  factory :manager do
    name { Faker::Name.first_name }
    sequence(:email) { |n| "heascook_manager#{n + 2}@ahk.jp" }
    password { 'password' }
    password_confirmation { 'password' }
    confirmation_sent_at { Time.zone.today - 2.days }
    confirmed_at { Time.zone.today - 1.day }
  end
end
