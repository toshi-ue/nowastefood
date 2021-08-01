class ManagecuisinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cuisine, only: [:update, :edit, :destroy]

  def index
    @cuisines = current_user.owner_cuisines
  end

  private

  def set_cuisine
    @cuisine = Cuisine.find(params[:id])
  end

  def cuisine_params
    params.require(:cuisine).permit(:name, :genre_id, :difficulty, :calories, :cooking_time, :description, :main_image, :tag_list)
  end
end
