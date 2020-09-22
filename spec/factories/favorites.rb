FactoryBot.define do
  factory :favorite do
    association :cuisine
    association :user
    # cuisine { nil }
    # user { nil }
  end
end
