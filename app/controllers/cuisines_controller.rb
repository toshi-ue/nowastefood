class CuisinesController < ApplicationController
  def show
    @cuisine = Cuisine.find(params[:id])
    @foodstuffs = Foodstuff.includes(:rawmaterial,{rawmaterial: :unit}).where(cuisine_id: @cuisine.id)
    # @genres
    @procedures = Procedure.where(cuisine_id: @cuisine.id)
  end
end
