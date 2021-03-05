class TopsController < ApplicationController
  def index
    @japanese_style_cuisines = Cuisine.where(genre_id: 1).limit(5)
    @western_style_cuisines = Cuisine.where(genre_id: 2).limit(4)
    @chinese_style_cuisines = Cuisine.where(genre_id: 3).limit(4)
    @genres = Genre.all
    @tags = ActsAsTaggableOn::Tag.all
  end

  # TODO: 検索機能を実装
  def search

  end

  def about
  end

  def login_which
  end
end
