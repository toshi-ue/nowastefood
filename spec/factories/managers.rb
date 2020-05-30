FactoryBot.define do
  factory :manager do
    sequence(:email) { |n| "manager#{n}@gmail.com" }
    password { 'password1234' }
    password_confirmation { 'password1234' }
    confirmation_sent_at { Time.zone.today - 2.days }
    confirmed_at { Time.zone.today - 1.day }
  end
end
