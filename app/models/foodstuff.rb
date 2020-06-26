class Foodstuff < ApplicationRecord
  belongs_to :cuisine
  belongs_to :cookedstate
  belongs_to :ingredient
  belongs_to :rawmaterial
  belongs_to :unit
  include RankedModel
  ranks :row_order
end
