# frozen_string_literal: true

class Todaysmenu < ApplicationRecord
  enum cooked_when: { morning: 1, lunch: 2, dinner: 3 }
  belongs_to :cuisine
  belongs_to :user
  # validate :uniqueness_cuisine_id_per_user_on_the_day, on: :create
  validates :serving_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  scope :not_cooked, lambda {
    where(cooked_when: nil)
  }

  scope :cooked, lambda {
    where.not(cooked_when: nil)
  }

  include CommonScope

  # def uniqueness_cuisine_id_per_user_on_the_day
  #   todaysmenu = Todaysmenu.where(cuisine_id: self.cuisine_id, user_id: self.user_id).not_cooked
  #   errors.add(:base, "すでに同じ料理が登録されています") if todaysmenu.exists?
  # end

  def self.create_hash_todaysmenus(todaysmenus)
    quantities = []
    todaysmenus.each do |tm|
      c = tm.cuisine
      c.foodstuffs.each do |fs|
        quantities.push([fs.rawmaterial_id, Rational(fs.quantity) * tm.serving_count])
      end
    end
    tmp_grouped_todaysmenus = quantities.group_by(&:first)
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
