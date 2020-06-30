class Procedure < ApplicationRecord
  include RankedModel
  ranks :row_order
  belongs_to :cuisine
  validates :cooking_detail, presence: true
  validates :cuisine_id, presence: true
end
