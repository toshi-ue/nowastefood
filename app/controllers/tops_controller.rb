class TopsController < ApplicationController
  def index
    @japanese_style_cuisines = Cuisine.japanese.published.eight_contents
    @western_style_cuisines = Cuisine.western.published.eight_contents
    @chinese_style_cuisines = Cuisine.chinese.published.eight_contents
    @other_style_cuisines = Cuisine.other.published.eight_contents
    @favorite_cuisines = Cuisine.published.includes(:user).where('favorites_count > ?', 0).order(favorites_count: :desc).limit(8)
  end

  def about; end

  def login_which; end
end
