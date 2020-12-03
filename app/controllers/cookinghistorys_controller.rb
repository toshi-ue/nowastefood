class CookinghistorysController < ApplicationController
  before_action :authenticate_user!

  def index
    @cuisine_ids_already_in = current_user.todaysmenus.search_in_today.pluck(:cuisine_id)
    @cookinghistorys = if current_user.subscribed
                         current_user.todaysmenus.includes(:cuisine).order(created_at: "DESC")
                       else
                         current_user.todaysmenus.where(created_at: Time.zone.now.ago(3.days).beginning_of_day..Time.zone.now.end_of_day).order(created_at: "DESC")
                       end
  end

  def add_to_todays_menu
    @todaysmenu = current_user.todaysmenus.build(cuisine_id: params[:cuisine_id])
    if @todaysmenu.save
      redirect_to cookinghistorys_path, flash: { notice: "#{@todaysmenu.cuisine.name} added." }
    else
      redirect_to cookinghistorys_path, flash: { error: @todaysmenu.errors.full_messages.to_s }
    end
  end

  def remove_from_todays_menus
    @todaysmenu = current_user.todaysmenus.find_by(cuisine_id: params[:cuisine_id], created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    @todaysmenu.destroy
    redirect_to cookinghistorys_path, flash: { notice: "#{@todaysmenu.cuisine.name} deleted." }
  end
end
