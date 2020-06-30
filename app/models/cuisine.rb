class Cuisine < ApplicationRecord
  # UNKNOWN: どのような順序が良いのか?
  include Discard::Model
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  enum difficulty: { easy: 0, normal: 1, hard: 2 }
  # has_many :rawmaterials
  # has_many :cookedstates
  has_many :foodstuffs, dependent: :destroy
  has_many :procedures, dependent: :destroy
  mount_uploader :main_image, ImageUploader
  validates :main_image, presence: { message: "を追加してください" }
end
