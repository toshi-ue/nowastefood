# frozen_string_literal: true

class Rawmaterial < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :hiragana, presence: true
  validates :expiry_period, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

  belongs_to :foodcategory
  belongs_to :unit
  belongs_to :user
  has_many :cuisines, through: :foodstuffs
  has_many :foodstuffs, dependent: :destroy
  has_many :stocks, dependent: :destroy
end
