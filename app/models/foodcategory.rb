class Foodcategory < ApplicationRecord
  include Discard::Model
  validates :name, presence: true, uniqueness: true
  has_many :rawmaterials
  has_many :cookedstates
end
