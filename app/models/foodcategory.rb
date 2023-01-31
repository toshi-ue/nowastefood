# frozen_string_literal: true

class Foodcategory < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :rawmaterials, dependent: :restrict_with_error
end
