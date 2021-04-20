class Foodcategory < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :rawmaterials
end
