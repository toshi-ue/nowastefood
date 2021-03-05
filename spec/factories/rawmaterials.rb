FactoryBot.define do
  factory :rawmaterial do
    association :foodcategory
    association :unit
    sequence(:name) { |n| "原材料名#{n}" }
    sequence(:hiragana) { |n| "ひらがな#{n}" }
  end
end
