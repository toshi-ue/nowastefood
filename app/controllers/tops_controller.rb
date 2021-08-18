class TopsController < ApplicationController
  def index
    @japanese_style_cuisines = Cuisine.where(genre_id: 1).limit(5)
    @western_style_cuisines = Cuisine.where(genre_id: 2).limit(5)
    @chinese_style_cuisines = Cuisine.where(genre_id: 3).limit(5)
    @genres = Genre.all
    @tags = ActsAsTaggableOn::Tag.all
    # binding.pry
  end

  def about; end

  def login_which; end
end
