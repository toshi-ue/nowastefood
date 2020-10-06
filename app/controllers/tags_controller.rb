class TagsController < ApplicationController
  KAMINARI_PAGINATION_COUNT = 12

  def search
    @cuisines = Cuisine.tagged_with(params[:tag_name].to_s).page(params[:page]).per(KAMINARI_PAGINATION_COUNT) if params[:tag_name]
  end
end
