class Cookedstate < ApplicationRecord
  include Discard::Model
  validates :name, presence: true, uniqueness: true
  validates :foodcategory_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3, message: 'を選択してください' }
  belongs_to :foodcategory
  has_many :cookedstates
end
