class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :set_app_name
  before_action :set_search_query

  def set_app_name
    @appname = "Coome"
  end

  def set_search_query
    search_params = params[:q]
    if search_params.present?
      if search_params["name_or_description_or_rawmaterials_name_or_rawmaterials_hiragana_cont"].present?
        @search = Cuisine.ransack(search_params)
        @search_word = search_params["name_or_description_or_rawmaterials_name_or_rawmaterials_hiragana_cont"]
      else
        @search = Cuisine.none.ransack(search_params)
        @search_word = nil
      end
    else
      @search = Cuisine.none.ransack(search_params)
      @search_word = nil
    end
  end
end
