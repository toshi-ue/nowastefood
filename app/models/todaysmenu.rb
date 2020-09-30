class Todaysmenu < ApplicationRecord
  belongs_to :cuisine
  belongs_to :user
  validate :uniqueness_cuisine_id_per_user_on_the_day, on: :create
  validates :serving_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def uniqueness_cuisine_id_per_user_on_the_day
    todaysmenu = Todaysmenu.where(cuisine_id: self.cuisine_id, user_id: self.user_id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    errors.add(:base, "すでに同じ料理が登録されています") if todaysmenu.exists?
  end
end
