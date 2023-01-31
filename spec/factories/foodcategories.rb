# frozen_string_literal: true

FactoryBot.define do
  factory :foodcategory do
    sequence(:name) { |n| "食材区分#{n + 1}" }
  end
end
