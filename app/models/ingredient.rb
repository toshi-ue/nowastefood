class Ingredient < ApplicationRecord
  include Discard::Model
  validates :name, presence: true, uniqueness: true
end
