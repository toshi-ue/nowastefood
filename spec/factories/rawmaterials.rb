FactoryBot.define do
  factory :rawmaterial do |n|
    association :foodcategory
    association :unit
    name { "原材料#{n}" }
    hiragana { "ひらがな#{n}" }
  end
end
