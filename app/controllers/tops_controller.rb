class TopsController < ApplicationController
  def index
    @japanese_style_cuisines = Cuisine.japanese.eight_contents
    @western_style_cuisines = Cuisine.western.eight_contents
    @chinese_style_cuisines = Cuisine.chinese.eight_contents
    @other_style_cuisines = Cuisine.other.eight_contents
    @favorite_cuisines = Cuisine.includes(:user).where('favorites_count > ?', 0).order(favorites_count: :desc).limit(8)
    # @tags = ActsAsTaggableOn::Tag.all
  end

  def about; end

  def login_which; end
end
