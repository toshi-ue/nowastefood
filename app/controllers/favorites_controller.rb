# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @favorites = current_user.favorites.includes(:cuisine)
    @cuisines = Cuisine.where(id: current_user.todaysmenus.not_cooked.map(&:cuisine_id))
  end

  def destroy
    @favorite = Favorite.find_by(id: params[:id])
    @favorite&.destroy!
    redirect_to favorites_path, flash: { notice: "#{@favorite.cuisine.name} がお気に入りから削除されました" }
  end

  def add_todaysmenu_from_favorite
    @todaysmenu = current_user.todaysmenus.build(cuisine_id: params[:cuisine_id], serving_count: current_user.default_serving_count)
    @todaysmenu.save!
    redirect_to favorites_path, flash: { notice: "#{@todaysmenu.cuisine.name}が今日の献立に追加されました" }
  end

  def remove_todaysmenu_from_favorite
    @todaysmenu = current_user.todaysmenus.not_cooked.find_by(cuisine_id: params[:cuisine_id])
    @todaysmenu.destroy!
    redirect_to favorites_path, flash: { notice: "#{@todaysmenu.cuisine.name} が今日の献立から削除されました" }
  end
end
