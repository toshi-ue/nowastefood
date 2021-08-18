class Foodstuff < ApplicationRecord
  before_validation :convert_specific_format
  belongs_to :cuisine
  belongs_to :rawmaterial
  counter_culture :rawmaterial
  validate :check_quantity
  include RankedModel
  ranks :row_order, with_same: :cuisine_id

  def convert_specific_format
    self.quantity = quantity.gsub(/ |　/, "").tr("／", "/").strip.tr('０-９', '0-9')
  end

  def self.best_cuisine(foodstuffs, todaysmenus, quantity_want_to_consume, user_serving_count)
    cuisines = {}
    foodstuffs.each do |fs|
      next if fs.rawmaterial.foodcategory_id == 4

      result_quantity = Rational(quantity_want_to_consume) - Rational(fs.quantity) * user_serving_count
      cuisines.store(fs.cuisine_id, result_quantity)
    end
    arr_branched_zero = cuisines.values.partition { |v| v <= 0 }
    optimal_value = if arr_branched_zero.first.present?
                      arr_branched_zero.first.max
                    elsif arr_branched_zero.second.present?
                      arr_branched_zero.second.min
                    end
    cuisines.key(optimal_value)
  end

  private

  def check_quantity
    return errors.add(:base, "数量は分数、数字または指定の文字で入力してください(例: 1/2, 120など)") if self.quantity.blank?

    if %r{\A[1-9１-９]*[/／]*[0-9０-９]*\z}.match?(self.quantity)
      true
    elsif /\A(適量|少々|お好みで){1}\z/.match?(self.quantity)
      true
    else
      errors.add(:base, "数量は分数、数字または指定の文字で入力してください(例: 1/2, 120など)")
    end
  end
end
