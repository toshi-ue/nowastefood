class Managers::TopsController < ApplicationController
  before_action :authenticate_manager!
  layout 'manager'

  def dashboard
  end
end
