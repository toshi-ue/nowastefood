FactoryBot.define do
  factory :procedure do
    association :cuisine
    sequence(:cooking_detail) { |i| "料理の手順_#{i}"}
    # row_order nil
  end
end
