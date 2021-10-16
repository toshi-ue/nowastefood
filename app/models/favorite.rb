class Favorite < ApplicationRecord
  belongs_to :cuisine
  belongs_to :user
  validates :cuisine_id, uniqueness: { scope: :user_id }

  counter_culture :cuisine
end
