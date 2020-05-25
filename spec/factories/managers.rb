FactoryBot.define do
  factory :manager do
    sequence(:email) { |n| "manager#{n}@gmail.com" }
    password { 'password1234' }
    password_confirmation { 'password1234' }
    confirmed_at { Date.today }
  end
end
