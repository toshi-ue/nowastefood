FactoryBot.define do
  factory :cuisine do
    association :user

    sequence(:name) { |n| "料理名#{n}" }
    cooking_time { Cuisine.cooking_times.keys.sample }
    genre { Cuisine.genres.keys.sample }
    sequence(:description) { |n| "料理名#{n}の説明" }
    sequence(:main_image) { File.new("#{Rails.root}/app/assets/images/test.jpg") }

    Cuisine.statuses.each_value do |value|
      trait :"#{value}" do
        status { value }
      end
    end
  end
end
