class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  @appname = "heasecook"
end
