Rawmaterial.seed_once(
  :id,
  { id: 1, name: "牛肉", hiragana: 'ぎゅうにく', min_quantity: 100, unit_id: 1, foodcategory_id: 1 },
  { id: 2, name: "豚肉", hiragana: 'ぶたにく', min_quantity: 100, unit_id: 1,  foodcategory_id: 1 },
  # 親子丼の食材
  { id: 3, name: "鶏もも肉", hiragana: "とりももにく", min_quantity: 100, unit_id: 1, foodcategory_id: 1 },
  { id: 4, name: "玉ねぎ", hiragana: "たまねぎ", min_quantity: 1, unit_id: 4, foodcategory_id: 2 },
  { id: 5, name: "卵", hiragana: "たまご", min_quantity: 1, unit_id: 4, foodcategory_id: 1 },
  { id: 6, name: "めんつゆ", hiragana: "めんつゆ", min_quantity: 5, unit_id: 2, foodcategory_id: 4 },
  { id: 7, name: "ごはん", hiragana: "ごはん", min_quantity: 0, unit_id: 1, foodcategory_id: 3 },
  { id: 8, name: "水", hiragana: "みず", min_quantity: 5, unit_id: 2, foodcategory_id: 5 },
  # ゴーヤチャンプルー
  { id: 9, name: "ゴーヤ", hiragana: "ごーや", min_quantity: 1, unit_id: 4, foodcategory_id: 2 },
  { id: 10, name: "木綿豆腐", hiragana: "もめんどうふ", min_quantity: 1, unit_id: 1, foodcategory_id: 2 },
  { id: 11, name: "もやし", hiragana: "もやし", min_quantity: 1, unit_id: 1, foodcategory_id: 2 },
  { id: 12, name: "ゴーヤチャンプルーのたれ", hiragana: "ごーやちゃんぷるーのたれ", min_quantity: 100, unit_id: 8, foodcategory_id: 4 },
  { id: 13, name: "塩", hiragana: "しお", min_quantity: 10, unit_id: 8, foodcategory_id: 4 },
  { id: 14, name: "豚バラ肉", hiragana: "ぶたばらにく", min_quantity: 100, unit_id: 1, foodcategory_id: 1 },
  { id: 15, name: "かつお節", hiragana: "かつおぶし", min_quantity: 10, unit_id: 8, foodcategory_id: 4 },
  { id: 16, name: "お湯", hiragana: "おゆ", min_quantity: 5, unit_id: 2, foodcategory_id: 5 },
  # タコ飯
  { id: 17, name: "タコ", hiragana: "たこ", min_quantity: 1, unit_id: 1, foodcategory_id: 6 },
  { id: 18, name: "生姜", hiragana: "しょうが", min_quantity: 1, unit_id: 4, foodcategory_id: 4 },
  { id: 19, name: "酒", hiragana: "さけ", min_quantity: 50, unit_id: 2, foodcategory_id: 4 },
  { id: 20, name: "和風だし", hiragana: "わふうだし", min_quantity: 10, unit_id: 2, foodcategory_id: 4 }
  # {id: , name: "", min_quantity: , foodcategory_id: },
)
# Foodcategory
# 1: 肉
# 2: 野菜
# 3: 炭水化物
# 4: 調味料
# 5: その他
# 6: 魚介類

# 1.親子丼
# [麺つゆだけで簡単親子丼 by アサムラサキ 【クックパッド】 簡単おいしいみんなのレシピが333万品](https://cookpad.com/recipe/4905547)
# [めんつゆで簡単 親子丼 作り方・レシピ | クラシル](https://www.kurashiru.com/recipes/04d7956b-97da-484b-8992-17df4fca2de9)

# 2.ゴーヤチャンプルー
# [苦味が少ない！簡単ゴーヤチャンプルー by 元料理人の時短レシピ 【クックパッド】 簡単おいしいみんなのレシピが333万品](https://cookpad.com/recipe/6321929)
# [苦さ控えめゴーヤチャンプルー 作り方・レシピ | クラシル](https://www.kurashiru.com/recipes/7514b07b-7df8-4b5d-a022-0245633c4434)

# 3.タコ飯
# [絶品たこ飯 by さくら2016 【クックパッド】 簡単おいしいみんなのレシピが333万品](https://cookpad.com/recipe/5721589)
# [簡単アレンジたこめし 作り方・レシピ | クラシル](https://www.kurashiru.com/recipes/905ce97e-ad49-4954-b131-400e6793e166)
