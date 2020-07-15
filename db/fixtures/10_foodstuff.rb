Foodstuff.seed_once(
  :id,
  # 親子丼
  {
    # 卵
    id: 1,
    quantity: "2",
    cuisine_id: 1,
    rawmaterial_id: 5, # 原材料id
    row_order: 0
  },
  {
    # 玉ねぎ
    id: 2,
    quantity: "1/4",
    cuisine_id: 1, # 料理id
    rawmaterial_id: 4, # 原材料id
    row_order: 0
  },
  {
    # 鶏肉
    id: 3,
    quantity: "100",
    cuisine_id: 1, # 料理id
    rawmaterial_id: 3, # 原材料id
    row_order: 0
  },
  {
    # めんつゆ
    id: 4,
    quantity: "40",
    cuisine_id: 1, # 料理id
    rawmaterial_id: 6, # 原材料id
    row_order: 0
  },
  {
    # 水
    id: 5,
    quantity: "50",
    cuisine_id: 1, # 料理id
    rawmaterial_id: 4, # 原材料id
    row_order: 0
  }
)
