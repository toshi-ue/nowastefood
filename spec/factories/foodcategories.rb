# frozen_string_literal: true

FactoryBot.define do
  factory :foodcategory do
    sequence(:name) { |n| "ι£ζεΊε#{n + 1}" }
  end
end
