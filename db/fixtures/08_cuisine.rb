require "fileutils"

# remove prev image files
Dir.chdir 'public/uploads/cuisine/'
FileUtils.rm(Dir.glob('*.*'))

Cuisine.seed_once(
  :id,
  {
    id: 1,
    name: "親子丼 with めんつゆ",
    difficulty: 0,
    calories: nil,
    cooking_time: 20,
    description: "味付けで失敗することがない簡単・お手軽な親子丼です!!",
    main_image: Rails.root.join("db/fixtures/images/oyakodon.jpg").open
  },
  {
    id: 2,
    name: "苦味少なめのゴーヤチャンプルー",
    difficulty: 1,
    calories: nil,
    cooking_time: 20,
    description: "味付けで失敗することがない簡単・お手軽な親子丼です!!",
    main_image: Rails.root.join("db/fixtures/images/go-ya_champru.jpg").open
  },
  {
    id: 3,
    name: "たこ飯",
    difficulty: 0,
    calories: nil,
    cooking_time: 30,
    description: "ぷりぷりなタコの旨みとだしが食欲をそそる1品",
    main_image: Rails.root.join("db/fixtures/images/takomesi.jpg").open
  }
)
