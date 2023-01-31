# frozen_string_literal: true

class KeywordsController < ApplicationController
  KAMINARI_PAGINATION_COUNT = 12
  def index
    @enum_key = params[:enum_key]
    case @enum_key
    when "japanese", "western", "chinese", "other"
      @cuisines = Cuisine.where(genre: @enum_key).includes(:user).page(params[:page]).per(KAMINARI_PAGINATION_COUNT)
    when "lt_minutes5", "lt_minutes10", "lt_minutes20", "gt_minutes21"
      @cuisines = Cuisine.where(cooking_time: @enum_key).includes(:user).page(params[:page]).per(KAMINARI_PAGINATION_COUNT)
    when "not-enum-ranking"
      @cuisines = Cuisine.includes(:user).where('favorites_count > ?', 0).order(favorites_count: :desc).page(params[:page]).per(KAMINARI_PAGINATION_COUNT)
    else
      redirect_to root_path, flash: { alert: "検索された値はありませんでした" }
    end
  end
end
