Foodstuff.seed_once(
  :id,
  # 親子丼
  {
    # 卵
    id: 1,
    quantity: "2",
    unit_id: 8,
    cuisine_id: 1,
    rawmaterial_id: 5, # 原材料id
    ingredient_id: nil, # 部位id
    cookedstate_id: nil, # 加工された状態の名前id
    row_order: 1
  },
  {
    # 玉ねぎ
    id: 2,
    quantity: "1/4",
    unit_id: 8, #単位id
    cuisine_id: 1, # 料理id
    rawmaterial_id: 4, # 原材料id
    ingredient_id: nil, # 部位id
    cookedstate_id: nil, # 加工された状態の名前id
    row_order: 2
  },
  {
    # 鶏肉
    id: 3,
    quantity: "100",
    unit_id: 5, #単位id
    cuisine_id: 1, # 料理id
    rawmaterial_id: 3, # 原材料id
    ingredient_id: 3, # 部位id
    cookedstate_id: nil, # 加工された状態の名前id
    row_order: 3
  },
  {
    # めんつゆ
    id: 4,
    quantity: "80",
    unit_id: 6, #単位id
    cuisine_id: 1, # 料理id
    rawmaterial_id: 6, # 原材料id
    ingredient_id: nil, # 部位id
    cookedstate_id: nil, # 加工された状態の名前id
    row_order: 4
  },
  {
    # 水
    id: 5,
    quantity: "50",
    unit_id: 5, # 単位id
    cuisine_id: 1, # 料理id
    rawmaterial_id: 8, # 原材料id
    ingredient_id: nil, # 部位id
    cookedstate_id: nil, # 加工された状態の名前id
    row_order: 5
  }
)
