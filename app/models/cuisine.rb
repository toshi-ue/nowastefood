class Cuisine < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  enum difficulty: { easy: 0, normal: 1, hard: 2 }
  # has_many :rawmaterials
  # has_many :cookedstates
  has_many :favorites
  has_many :foodstuffs, dependent: :destroy
  has_many :procedures, dependent: :destroy
  has_many :todaysmenus, dependent: :destroy
  mount_uploader :main_image, ImageUploader
  validates :main_image, presence: { message: "を追加してください" }
end
