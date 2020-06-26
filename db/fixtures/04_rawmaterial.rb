Rawmaterial.seed_once(
  :id,
  {id: 1, name: "牛肉", min_quantity: 100, foodcategory_id: 1},
  {id: 2, name: "豚肉", min_quantity: 100, foodcategory_id: 1},
  # 親子丼の食材
  {id: 3, name: "鶏肉", min_quantity: 100, foodcategory_id: 1},
  {id: 4, name: "玉ねぎ", min_quantity: 1, foodcategory_id: 2},
  {id: 5, name: "卵", min_quantity: 1, foodcategory_id: 1},
  {id: 6, name: "めんつゆ", min_quantity: 5, foodcategory_id: 4},
  {id: 7, name: "ごはん", min_quantity: 0, foodcategory_id: 3},
  {id: 8, name: "水", min_quantity: 5, foodcategory_id: 4}
  # {id: 8, name: "", min_quantity: , foodcategory_id: }
)

# Rawmaterial.seed_once do |s|
#   s.id = 1
#   s.name = "牛肉"
#   s.min_quantity = 100
#   s.foodcategory_id = 1
# end

# Rawmaterial.seed_once do |s|
#   s.id = 2
#   s.name = "豚肉"
#   s.min_quantity = 100
#   s.foodcategory_id = 1
# end


# 親子丼
# [麺つゆだけで簡単親子丼 by アサムラサキ 【クックパッド】 簡単おいしいみんなのレシピが333万品](https://cookpad.com/recipe/4905547)
# [めんつゆで簡単 親子丼 作り方・レシピ | クラシル](https://www.kurashiru.com/recipes/04d7956b-97da-484b-8992-17df4fca2de9)

Rawmaterial.seed_once do |s|
  s.id = 3
  s.name = "鶏肉"
  s.min_quantity = 100
  s.foodcategory_id = 1
end

Rawmaterial.seed_once do |s|
  s.id = 4
  s.name = "玉ねぎ"
  s.min_quantity = 1
  s.foodcategory_id = 2
end

Rawmaterial.seed_once do |s|
  s.id = 5
  s.name = "卵"
  s.min_quantity = 1
  s.foodcategory_id = 1
end

Rawmaterial.seed_once do |s|
  s.id = 6
  s.name = "めんつゆ"
  s.min_quantity = 10
  s.foodcategory_id = 4
end

Rawmaterial.seed_once do |s|
  s.id = 7
  s.name = "ごはん"
  s.min_quantity = 0
  s.foodcategory_id = 3
end





# Foodcategory.seed_once do |s|
#   s.id = 1
#   s.name = "肉"
# end

# Foodcategory.seed_once do |s|
#   s.id = 2
#   s.name = "野菜"
# end

# Foodcategory.seed_once do |s|
#   s.id = 3
#   s.name = "炭水化物"
# end

# Foodcategory.seed_once do |s|
#   s.id = 4
#   s.name = "調味料"
# end

# Foodcategory.seed_once do |s|
#   s.id = 5
#   s.name = "その他"
# end
