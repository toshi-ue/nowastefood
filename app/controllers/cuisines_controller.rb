# frozen_string_literal: true

class CuisinesController < ApplicationController
  def show
    @cuisine = Cuisine.find(params[:id])
    @foodstuffs = Foodstuff.includes(:rawmaterial, { rawmaterial: :unit }).where(cuisine_id: @cuisine.id)
    # @genres
    # TODO: あとでGenre, Tags機能を実装した時に @genres, @tagsを追加する
    @procedures = Procedure.where(cuisine_id: @cuisine.id)
  end

  def add_favorite
    @favorite = current_user.favorites.build(cuisine_id: params[:cuisine_id])
    @favorite.save
    @cuisine = Cuisine.find_by(id: params[:cuisine_id])
  end

  def add_menu
    @todaysmenu = current_user.todaysmenus.build(cuisine_id: params[:cuisine_id])
    @todaysmenu.save
    @cuisine = Cuisine.find_by(id: params[:cuisine_id])
  end

  def remove_favorite
    @favorite = current_user.favorites.find_by(cuisine_id: params[:cuisine_id])
    @favorite.destroy
    @cuisine = Cuisine.find_by(id: params[:cuisine_id])
  end

  # TODO: create_atを削除する
  def remove_menu
    @todaysmenu = current_user.todaysmenus.find_by(cuisine_id: params[:cuisine_id], created_at: Time.zone.now.all_day)
    @todaysmenu.destroy
    @cuisine = Cuisine.find_by(id: params[:cuisine_id])
  end

  def search
    @cuisines = @search.result.includes(:user).distinct.page(params[:page]).per(5)
  end
end
