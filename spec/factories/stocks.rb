FactoryBot.define do
  factory :stock do
    association :rawmaterial
    association :user
    quantity { 10 }
  end
end
