FactoryBot.define do
  factory :stock do
    quantity { rand(1..100).to_s }
    rawmaterial { nil }
    user { nil }
  end
end
