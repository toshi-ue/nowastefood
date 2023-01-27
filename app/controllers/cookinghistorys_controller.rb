class CookinghistorysController < ApplicationController
  before_action :authenticate_user!

  def index
    @cuisine_ids_already_in = current_user.todaysmenus.search_in_today.pluck(:cuisine_id)
    @cookinghistorys = current_user.todaysmenus.includes(:cuisine).cooked.order(created_at: "DESC")
    @cookinghistorys = @cookinghistorys.page(params[:page]).per(20)
  end

  def destroy
    binding.pry
    @cookinghistory = current_user.todaysmenus.find_by(id: params[:id])
    @cookinghistory.destroy
     redirect_to cookinghistorys_path, flash: { notice: "料理履歴から #{@cookinghistory.cuisine.name} を削除しました" }
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
    now = Time.zone.now
    @todaysmenu = current_user.todaysmenus.find_by(cuisine_id: params[:cuisine_id], created_at: now.all_day)
    @todaysmenu.destroy
    redirect_to cookinghistorys_path, flash: { notice: "#{@todaysmenu.cuisine.name} を削除しました" }
  end
end
