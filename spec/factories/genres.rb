FactoryBot.define do
  factory :genre do
    sequence(:name) { |i| "ジャンル名#{i}"}
  end
end
