# frozen_string_literal: true

class Unit < ApplicationRecord
  validates :name, presence: true

  has_many :rawmaterials
end
