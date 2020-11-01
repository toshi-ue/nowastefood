class Cuisine < ApplicationRecord
  enum difficulty: { easy: 0, normal: 1, hard: 2 }
  # has_many :rawmaterials
  # has_many :cookedstates
  belongs_to :genre
  has_many :favorites
  has_many :foodstuffs, dependent: :destroy
  has_many :procedures, dependent: :destroy
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
end
