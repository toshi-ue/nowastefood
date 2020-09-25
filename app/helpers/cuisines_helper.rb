module CuisinesHelper
  def disp_foodstuff(instance)
    if instance.ingredient_id.present? && instance.cookedstate_id.present?
      "#{instance.rawmaterial.name}#{instance.ingredient.name}#{instance.cookedstate.name}"
    elsif instance.ingredient_id.present?
      "#{instance.rawmaterial.name}#{instance.ingredient.name}"
    else
      instance.rawmaterial.name.to_s
    end
  end

  def disp_quantity(instance)
    "#{instance.quantity}#{instance.unit.name}"
  end
end
