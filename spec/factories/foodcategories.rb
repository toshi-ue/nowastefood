FactoryBot.define do
  factory :foodcategory do
    sequence(:name) { |n| "料理区分#{n}" }
  end
end
