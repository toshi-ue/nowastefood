# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    category { Contact.categories.keys.sample }
    user_name { Faker::Name.first_name }
    sequence(:subject) { |n| "用件 #{n + 1}" }
    sequence(:message) { |n| "問い合わせ本文 #{n + 1}" }
  end
end
