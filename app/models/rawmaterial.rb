class Rawmaterial < ApplicationRecord
  include Discard::Model
  validates :name, presence: true, uniqueness: true
  has_one :nutrient, inverse_of: :rawmaterial
  belongs_to :foodcategory
  accepts_nested_attributes_for :nutrient, update_only: true
end
