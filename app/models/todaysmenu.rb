class Todaysmenu < ApplicationRecord
  belongs_to :cuisine
  belongs_to :user
  validates_uniqueness_of :cuisine_id, scope: :user_id
end
