class Todaysmenu < ApplicationRecord
  belongs_to :cuisine
  belongs_to :user
  validate :uniqueness_cuisine_id_per_user_on_the_day, on: :create
  validates :serving_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  include CommonScope

  def uniqueness_cuisine_id_per_user_on_the_day
    todaysmenu = Todaysmenu.where(cuisine_id: self.cuisine_id, user_id: self.user_id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    errors.add(:base, "すでに同じ料理が登録されています") if todaysmenu.exists?
  end

  def self.create_hash_todaysmenus(todaysmenus)
    quantities = []
    todaysmenus.each do |tm|
      c = tm.cuisine
      c.foodstuffs.each do |fs|
        quantities.push([fs.rawmaterial_id, Rational(fs.quantity) * tm.serving_count])
      end
    end
    tmp_grouped_todaysmenus = quantities.group_by do |r|
      r.first
    end
    tmp_grouped_todaysmenus.each do |k, v|
      tmp_grouped_todaysmenus[k] = v.inject(0) do |sum, arr|
        sum += Rational(arr.last)
      end
    end
    grouped_todaysmenus = tmp_grouped_todaysmenus
  end
end
