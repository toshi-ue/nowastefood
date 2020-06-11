class Cuisine < ApplicationRecord
  include Discard::Model
  validates :name, presence: true, uniqueness: true
  enum difficulty: { easy: 0, normal: 1, hard: 2 }
  # has_many :rawmaterials
  # has_many :cookedstates
end
