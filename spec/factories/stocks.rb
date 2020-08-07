FactoryBot.define do
  factory :stock do
    association :rawmaterial
    association :user
    # ランダムじゃなくてもいいのか?
    quantity { rand(1..100).to_s }
  end
end
