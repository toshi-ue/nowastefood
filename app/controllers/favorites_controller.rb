class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  # TODO: セレクトボックスでソート機能を実装するか検討
  def index
    @favorites = current_user.favorites
  end

  def create
    @favorite = current_user.favorites.build(cuisine_id: params[:cuisine_id])
    @favorite.save
    @cuisine = Cuisine.find_by(id: params[:cuisine_id])
  end

  def destroy
    @favorite = Favorite.find_by(id: params[:id])
    @favorite&.destroy
    redirect_to favorites_path, flash: { notice: "Favoriteから削除されました"}
  end

  def add_menu_on_the_day
    @todaysmenus_ids = current_user.todaysmenus.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).pluck(:cuisine_id)
    @todaysmenu = current_user.todaysmenus.build(cuisine_id: params[:cuisine_id])
    if @todaysmenus_ids.include?(@todaysmenu.cuisine_id)
      redirect_to favorites_path, flash: { notice: "すでにTodayに追加されています"}
    else
      @todaysmenu.serving_count = current_user.default_serving_count == 1 ? 1 : current_user.default_serving_count
      @todaysmenu.save
      redirect_to favorites_path, flash: { notice: "Todayに追加されました"}
    end
  end
end
