# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :cuisine
  belongs_to :user
  validates :cuisine_id, uniqueness: { scope: :user_id }

  counter_culture :cuisine, delta_magnitude: 1
end
