class CookinghistorysController < ApplicationController
  before_action :authenticate_user!

  def index
    current_user.todaysmenus
  end
end
