class Managers::FoodstuffsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_foodstuff, only: [:update, :edit, :destroy, :restore]

  layout 'manager'
  def index
    @foodstuffs = Foodstuff.includes({ rawmaterial: :unit })
  end

  def new
    @foodstuff = Foodstuff.new
    @foodstuff.cuisine_id = params[:cuisine_id]
    @cuisine = Cuisine.find(@foodstuff.cuisine_id)
    @registered_fs = Foodstuff.includes(:rawmaterial, rawmaterial: :unit).where(cuisine_id: @foodstuff.cuisine_id)
  end

  def create
    @foodstuff = Foodstuff.new(foodstuff_params)
    if @foodstuff.save
      redirect_to new_managers_foodstuff_path(cuisine_id: @foodstuff.cuisine_id), flash: { notice: "#{@foodstuff.rawmaterial.name} が追加されました" }
    else
      @rawmaterial = Rawmaterial.find_by(id: @foodstuff.rawmaterial_id)
      @cuisine = Cuisine.find(@foodstuff.cuisine_id)
      @registered_fs = Foodstuff.includes(:rawmaterial, rawmaterial: :unit).where(cuisine_id: @foodstuff.cuisine_id)
      render 'new'
    end
  end

  def edit
    @rawmaterial = Rawmaterial.find_by(id: @foodstuff.rawmaterial_id)
  end

  def update
    if @foodstuff.update(foodstuff_params)
      redirect_to managers_cuisine_path(@foodstuff.cuisine_id), flash: { notice: "変更されました" }
    else
      @rawmaterial = Rawmaterial.find_by(id: @foodstuff.rawmaterial_id)
      render 'edit'
    end
  end

  def destroy
    @foodstuff.destroy
    redirect_to managers_cuisine_path(@foodstuff.cuisine_id), flash: { notice: "#{@foodstuff.rawmaterial.name} が削除されました" }
  end

  def restore
    @foodstuff.undiscard
    redirect_to managers_foodstuffs_path, flash: { notice: "#{@foodstuff} が復元されました" }
  end

  def sort
    @foodstuff = Foodstuff.find(params[:id])
    @foodstuff.update(foodstuff_params)
    head :ok
  end

  def search_rawmaterial
    @rawmaterials = Rawmaterial.where('name LIKE ? OR hiragana LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
  end

  private

  def set_foodstuff
    @foodstuff = Foodstuff.find(params[:id])
  end

  def foodstuff_params
    params.require(:foodstuff).permit(:id, :quantity, :cuisine_id, :rawmaterial_id, :row_order_position)
  end
end
