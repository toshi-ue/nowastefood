module Managers::FoodstuffsHelper
  def disp_ingredient_name(instance)
    "(#{instance.ingredient.name})" if instance.ingredient_id.present?
  end

  def disp_cookedstate_name(instance)
    instance.cookedstate.name.to_s if instance.cookedstate_id.present?
  end
end
