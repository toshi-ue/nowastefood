# frozen_string_literal: true

FactoryBot.define do
  factory :unit do |n|
    name { "単位の名前#{n}" }
  end
end
