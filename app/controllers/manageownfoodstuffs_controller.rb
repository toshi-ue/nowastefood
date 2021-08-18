class ManageownfoodstuffsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_foodstuff, only: [:edit, :update]

  def new
    @cuisine = Cuisine.find(params[:cuisine_id])
    @foodstuffs = Foodstuff.includes(rawmaterial: :unit).where(cuisine_id: params[:cuisine_id])
    @procedures = Procedure.where(cuisine_id: params[:cuisine_id])
    @rawmaterials = Rawmaterial.limit(5)
    @foodstuff = Foodstuff.new
  end

  def create
    @foodstuff = Foodstuff.new(foodstuff_params)
    if @foodstuff.save
      redirect_to new_manageownfoodstuff_path(cuisine_id: @foodstuff.cuisine_id), flash: { notice: "#{@foodstuff.rawmaterial.name} が追加されました" }
    else
      @cuisine = Cuisine.find(@foodstuff.cuisine_id)
      @foodstuffs = Foodstuff.includes(rawmaterial: :unit).where(cuisine_id: params[:cuisine_id])
      @procedures = Procedure.where(cuisine_id: params[:cuisine_id])
      @rawmaterials = Rawmaterial.limit(5)
      params[:cuisine_id] = @foodstuff.cuisine_id
      render 'new'
    end
  end

  def edit
    @cuisine = Cuisine.find(@foodstuff.cuisine_id)
    @procedures = Procedure.where(cuisine_id: @cuisine.id)
    @rawmaterials = Rawmaterial.limit(5)
    @foodstuffs = Foodstuff.includes(rawmaterial: :unit).where(cuisine_id: @cuisine.id).where.not(params[:id])
  end

  def update
    if @foodstuff.update(foodstuff_params)
      redirect_to managecuisine_path(@foodstuff.cuisine_id), flash: { notice: "変更されました" }
    else
      @cuisine = Cuisine.find(@foodstuff.cuisine_id)
      @foodstuffs = Foodstuff.includes(rawmaterial: :unit).where(cuisine_id: params[:cuisine_id])
      @procedures = Procedure.where(cuisine_id: @cuisine.id)
      @rawmaterials = Rawmaterial.limit(5)
      params[:cuisine_id] = @foodstuff.cuisine_id
      render 'edit'
    end
  end

  def destroy
    @foodstuff = Foodstuff.find(params[:id])
    @foodstuff.destroy
    redirect_to new_manageownfoodstuff_path(cuisine_id: @foodstuff.cuisine_id), flash: { notice: "#{@foodstuff.rawmaterial.name} が削除されました" }
  end

  private

  def set_foodstuff
    @foodstuff = Foodstuff.find(params[:id])
  end

  def foodstuff_params
    params.require(:foodstuff).permit(:id, :quantity, :cuisine_id, :rawmaterial_id, :row_order_position)
  end
end
