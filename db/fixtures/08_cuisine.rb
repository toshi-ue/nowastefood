Cuisine.seed_once(
  :id,
  {
    id: 1,
    name: "親子丼 with めんつゆ",
    difficulty: 0,
    calories: nil,
    cooking_time: 20,
    main_image: Rails.root.join("db/fixtures/images/oyakodon_width_400.jpg").open
  }
)

# Cuisine.seed_once do |s|
#   s.id = 1
#   s.name = "肉料理1"
#   s.difficulty = 0
#   s.calories = nil
#   s.cooking_time = 10
#   s.main_image = nil
# end

# Cuisine.seed_once do |s|
#   s.id = 2
#   s.name = "魚料理1"
#   s.difficulty = 1
#   s.calories = nil
#   s.cooking_time = 20
#   s.main_image = nil
# end

# Cuisine.seed_once do |s|
#   s.id = 3
#   s.name = "親子丼 with めんつゆ"
#   s.difficulty = 1
#   s.calories = nil
#   s.cooking_time = 20
#   s.main_image = nil
# end
