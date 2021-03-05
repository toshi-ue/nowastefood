module Managers::CuisinesHelper
  def disp_cookedstate_name(instance)
    instance.cookedstate.name.to_s if instance.cookedstate_id.present?
  end
end
