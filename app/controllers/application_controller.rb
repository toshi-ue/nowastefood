class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :set_app_name
  before_action :set_search_query
  before_action :store_user_location!, if: :storable_location?

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

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
