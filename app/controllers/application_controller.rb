class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :set_app_name
  before_action :set_search_query
  before_action :store_user_location!, if: :storable_location?

  if Rails.env.production?
    rescue_from StandardError, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    def render_404
      render file: Rails.root.join('public/404.html'), status: :not_found, layout: false, content_type: 'text/html'
    end

    def render_500(e)
      ExceptionNotifier.notify_exception(e, env: request.env, data: { message: 'error' })
      logger.error(e.message)
      logger.error(e.backtrace.join("\n"))
      render file: Rails.root.join('public/500.html'), status: :internal_server_error, layout: false, content_type: 'text/html'
    end
  end

  # TODO: 完成したらアプリ名を入れる
  def set_app_name
    @app_name = "サービス名"
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
