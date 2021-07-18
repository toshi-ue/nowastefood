class Todaysmenu < ApplicationRecord
  belongs_to :cuisine
  belongs_to :user
  validate :uniqueness_cuisine_id_per_user_on_the_day, on: :create
  validates :serving_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  scope :not_cooked, lambda {
    where(cooked_when: nil)
  }

  include CommonScope

  def uniqueness_cuisine_id_per_user_on_the_day
    todaysmenu = Todaysmenu.where(cuisine_id: self.cuisine_id, user_id: self.user_id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    errors.add(:base, "すでに同じ料理が登録されています") if todaysmenu.exists?
  end

  def self.create_hash_todaysmenus(todaysmenus)
    quantities = []
    todaysmenus.each do |tm|
      c = tm.cuisine
      # binding.pry
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

  def self.get_quantities_grouped_by_rawmaterial(todaysmenus:)
    return {} if todaysmenus.blank?

    uncalculated_rawmaterials = []
    todaysmenus.each do |tm|
      cuisine = tm.cuisine
      cuisine.foodstuffs.each do |fs|
        uncalculated_rawmaterials.push([fs.rawmaterial_id, Rational(fs.quantity) * tm.serving_count])
      end
    end
    quantities_grouped_rawmaterial = uncalculated_rawmaterials.group_by(&:first)
    quantities_grouped_rawmaterial.each do |k, v|
      quantities_grouped_rawmaterial[k] = v.inject(0) do |sum, arr|
        sum += Rational(arr.last)
      end
    end
    quantities_grouped_rawmaterial.sort.to_h
  end
end
