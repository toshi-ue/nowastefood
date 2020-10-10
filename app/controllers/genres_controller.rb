class GenresController < ApplicationController
  KAMINARI_PAGINATION_COUNT = 12

  def search
    @genre_name = Genre.find_by(id: params[:id]).name
    @cuisines = Cuisine.where(genre_id: params[:id]).page(params[:page]).per(KAMINARI_PAGINATION_COUNT)
  end
end
