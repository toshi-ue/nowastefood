class Rawmaterial < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :hiragana, presence: true, uniqueness: true
  belongs_to :foodcategory
  belongs_to :unit
  belongs_to :user
  has_many :cuisines, through: :foodstuffs
  has_many :foodstuffs, dependent: :destroy
  has_many :stocks, dependent: :destroy
end
