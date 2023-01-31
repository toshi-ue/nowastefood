# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :set_app_name
  before_action :set_search_query
  before_action :store_user_location!, if: :storable_location?

  if Rails.env.production?
    rescue_from StandardError, with: :render500
    rescue_from ActiveRecord::RecordNotFound, with: :render404

    def render404
      render file: Rails.public_path.join('404.html'), status: :not_found, layout: false, content_type: 'text/html'
    end

    def render500(e)
      ExceptionNotifier.notify_exception(e, env: request.env, data: { message: 'error' })
      logger.error(e.message)
      logger.error(e.backtrace.join("\n"))
      render file: Rails.public_path.join('500.html'), status: :internal_server_error, layout: false, content_type: 'text/html'
    end
  end

  def check_owner(owner, login_user)
    return unless owner.id != login_user.id

    flash[:alert] = "該当するレシピはオーナーのみ変更できます"
    redirect_back(fallback_location: root_path)
  end

  def set_app_name
    @app_name = "NoWasteFood"
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
