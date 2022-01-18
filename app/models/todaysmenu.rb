# frozen_string_literal: true

class Todaysmenu < ApplicationRecord
  enum cooked_when: { morning: 1, lunch: 2, dinner: 3 }
  belongs_to :cuisine
  belongs_to :user
  validates :serving_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  scope :not_cooked, -> { where(cooked_when: nil) }

  scope :cooked, -> { where.not(cooked_when: nil) }

  include CommonScope

  def self.create_hash_todaysmenus(todaysmenus)
    quantities = []
    todaysmenus.each do |todaysmenu|
      c = todaysmenu.cuisine
      c.foodstuffs.each do |foodstuff|
        quantities.push([foodstuff.rawmaterial_id, Rational(foodstuff.quantity) * todaysmenu.serving_count])
      end
    end
    grouped_todaysmenus = quantities.group_by(&:first)
    grouped_todaysmenus.each do |k, v|
      grouped_todaysmenus[k] = v.inject(0) do |sum, arr|
        sum += Rational(arr.last)
      end
    end
    grouped_todaysmenus
  end

  def self.get_quantities_grouped_by_rawmaterial(todaysmenus:)
    return {} if todaysmenus.blank?

    uncalculated_rawmaterials = []
    todaysmenus.each do |todaysmenu|
      cuisine = todaysmenu.cuisine
      cuisine.foodstuffs.each do |foodstuff|
        uncalculated_rawmaterials.push([foodstuff.rawmaterial_id, Rational(foodstuff.quantity) * todaysmenu.serving_count])
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
