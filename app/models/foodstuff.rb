class Foodstuff < ApplicationRecord
  belongs_to :cuisine
  belongs_to :rawmaterial
  belongs_to :unit

  # ranked-model
  include RankedModel
  ranks :row_order, with_same: :cuisine_id
end
