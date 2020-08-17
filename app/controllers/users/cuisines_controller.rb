class Users::CuisinesController < ApplicationController
  def show
    @cuisine = Cuisine.find(params[:id])
    @foodstuffs = Foodstuff.includes(:rawmaterial).where(cuisine_id: @cuisine.id)
    @procedures = Procedure.where(cuisine_id: @cuisine.id)
  end
end
