class Ingredient < ApplicationRecord
  include Discard::Model
  validates :name, presence: true, uniqueness: true
  has_many :foodstuffs
end
