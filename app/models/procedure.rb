class Procedure < ApplicationRecord
  include RankedModel
  ranks :row_order
  belongs_to :cuisine
end
