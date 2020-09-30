class TodaysmenusController < ApplicationController
  before_action :authenticate_user!
  def index
    @todaysmenus = current_user.todaysmenus.includes(:cuisine).where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def update
    @todaysmenu = Todaysmenu.find_by(id: params[:id])
    @todaysmenu.update(todaysmenu_params)
  end

  def destroy
    @todaysmenu = Todaysmenu.find_by(params[:id])
    @todaysmenu.destroy
    redirect_to todaysmenus_path, flash: { notice: "#{@todaysmenu.cuisine.name}を削除しました"}
  end

  private
  def todaysmenu_params
    params.require(:todaysmenu).permit(:cuisine_id, :user_id, :serving_count)
  end
end
