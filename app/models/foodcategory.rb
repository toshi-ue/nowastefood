class Foodcategory < ApplicationRecord
  include Discard::Model
  validates :name, presence: true, uniqueness: true
  belongs_to :manager
end
