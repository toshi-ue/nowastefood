# frozen_string_literal: true

class Procedure < ApplicationRecord
  # ranked-model
  include RankedModel
  ranks :row_order, with_same: :cuisine_id

  validates :cooking_detail, presence: true

  belongs_to :cuisine
end
