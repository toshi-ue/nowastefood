class Cuisine < ApplicationRecord
  enum cooking_time: { lt_minutes5: 5, lt_minutes10: 10, lt_minutes20: 20, gt_minutes21: 21 }
  enum difficulty: { easy: 0, normal: 1, hard: 2 }
  enum genre: { japanese: 1, western: 2, chinese: 3, other: 99 }

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :foodstuffs, dependent: :destroy
  has_many :procedures, dependent: :destroy
  has_many :rawmaterials, through: :foodstuffs
  has_many :todaysmenus, dependent: :destroy
  validates :description, presence: true
  validates :genre, presence: true
  validates :name, presence: true, uniqueness: true
  validates :main_image, presence: { message: "を追加してください" }

  scope :eight_contents, -> { includes(:user).limit(8) }

  include CommonScope
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
