class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :set_app_name

  def set_app_name
    @appname = "Coome"
  end
end
