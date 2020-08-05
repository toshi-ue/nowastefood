FactoryBot.define do
  factory :rawmaterial do
    name { |n| "原材料#{n}" }
    hiragana { |n| "ひらがな#{n}" }
    unit_id {}
    foodcategory_id {}
  end
end
