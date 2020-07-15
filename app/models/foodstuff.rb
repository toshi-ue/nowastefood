class Foodstuff < ApplicationRecord
  belongs_to :cuisine
  belongs_to :rawmaterial

  # ranked-model
  include RankedModel
  ranks :row_order, with_same: :cuisine_id
end
