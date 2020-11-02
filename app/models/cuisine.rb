class Cuisine < ApplicationRecord
  enum difficulty: { easy: 0, normal: 1, hard: 2 }
  # has_many :rawmaterials
  # has_many :cookedstates
  belongs_to :genre
  has_many :favorites
  has_many :foodstuffs, dependent: :destroy
  has_many :procedures, dependent: :destroy
  has_many :rawmaterials, through: :foodstuffs
  has_many :todaysmenus, dependent: :destroy
  validates :description, presence: true
  validates :genre_id, presence: { message: "を選択してください" }
  validates :name, presence: true, uniqueness: true
  validates :main_image, presence: { message: "を追加してください" }

  acts_as_taggable
  counter_culture :genre
  mount_uploader :main_image, ImageUploader

  TAGS = [
    "定番",
    "子供OK",
    "下準備だけ!!",
    "ヘルシー",
    "一人でパパッと",
    "コスパ◎",
    "ボリューム満点",
    "やさしい味",
    "野菜たっぷり",
    "お手軽",
    "家庭の味",
    "10分でできる!!",
    "あと1品",
    "大人数で",
    "汁物"
  ].freeze

  def aaa(quantity, cuisine_id, rawmaterial_id, default_serving_count)
    new_quantity = Foodstuff.find_by(cuisine_id: cuisine_id, rawmaterial_id: rawmaterial_id).quantity
    rational_value_result = Rational(quantity) - Rational(new_quantity) * default_serving_count
    # binding.pry
    [cuisine_id, rational_value_result]
    # binding.pry
  end
end

# [has_many through のアソシエーションに条件を追加する - Qiita](https://qiita.com/QUANON/items/a58ff3960b43af472bfb)

# [関連するモデルの条件で検索したい - Qiita](https://qiita.com/ishidamakot/items/7dba557d764362a828ff#%E7%89%B9%E5%AE%9A%E3%81%AE%E5%95%86%E5%93%81%E3%82%92%E6%B3%A8%E6%96%87%E3%81%97%E3%81%9F%E9%A1%A7%E5%AE%A2%E3%82%92%E6%8A%BD%E5%87%BA)

# [ActiveRecordのjoinsとpreloadとincludesとeager_loadの違い - Qiita](https://qiita.com/k0kubun/items/80c5a5494f53bb88dc58)
