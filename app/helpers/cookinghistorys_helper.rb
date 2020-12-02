module CookinghistorysHelper
  def check_already_in(cuisine_id, cuisine_ids)
    # binding.pry
    "disabled" if cuisine_ids.include?(cuisine_id)
  end
end
