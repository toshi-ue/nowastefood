class TodaysmenusController < ApplicationController
  before_action :authenticate_user!
  def index
    @todaysmenus = current_user.todaysmenus.includes(:cuisine)
  end

  def destroy
    @todaysmenu = Todaysmenu.find_by(params[:id])
    @todaysmenu.destroy
    redirect_to todaysmenus_path
  end
end
