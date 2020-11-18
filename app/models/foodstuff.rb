class Foodstuff < ApplicationRecord
  before_validation :convert_specific_format # 空白を削除, 全角があれば半角に
  belongs_to :cuisine
  belongs_to :rawmaterial
  counter_culture :rawmaterial
  validate :uniqueness_rawmaterial_id
  validates :quantity, presence: true, format: { with: %r{\A[1-9１-９]*[/／]*[0-9０-９]*\z}, message: "は分数もしくは数字で入力してください(例: 1/2, 120など)" }
  include RankedModel
  ranks :row_order, with_same: :cuisine_id

  def convert_specific_format
    self.quantity = quantity.gsub(/ |　/, "").tr("／", "/").strip.tr('０-９', '0-9')
  end

  def self.best_cuisine(foodstuffs, todaysmenus, quantity_want_to_consume, user_serving_count)
    cuisines = {}
    foodstuffs.each do |fs|
      result_quantity = Rational(quantity_want_to_consume) - Rational(fs.quantity) * user_serving_count
      cuisines.store(fs.cuisine_id, result_quantity)
    end
    candidates = cuisines.delete_if { |key, _| todaysmenus.include?(key) }
    optimal_value = candidates.values.partition { |v| v <= 0 }[0].first
    cuisines.key(optimal_value)
  end

  private

  def uniqueness_rawmaterial_id
    foodstuff = Foodstuff.find_by(cuisine_id: self.cuisine_id, rawmaterial_id: self.rawmaterial_id)
    errors.add(:base, "1つの料理に同じ材料を登録できません") if foodstuff && foodstuff.id != self.id
  end
end
