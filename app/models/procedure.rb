class Procedure < ApplicationRecord
  belongs_to :cuisine
  validates :cooking_detail, presence: true
  validates :cuisine_id, presence: true

  # ranked-model
  include RankedModel
  ranks :row_order, with_same: :cuisine_id
end
