FactoryBot.define do
  factory :foodcategory do
    sequence(:name) { |n| "食材区分#{n}" }
  end
end
