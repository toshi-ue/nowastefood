class Managers::FoodstuffsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_foodstuff, only: [:update, :edit, :destroy, :restore]
  layout 'manager'

  def index
    @foodstuffs = Foodstuff.includes({ rawmaterial: :unit })
  end

  def new
    # HACK: ここの無理やり感をなんとかしたい
    @cuisine = Cuisine.find(params[:cuisine_id])
    @foodstuff = Foodstuff.new
  end

  def create
    @foodstuff = Foodstuff.new(foodstuff_params)
    if @foodstuff.save
      redirect_to new_managers_foodstuff_path(cuisine_id: @foodstuff.cuisine_id), flash: { notice: "#{@foodstuff.rawmaterial.name} が追加されました" }
    else
      # HACK: render 'new'を使ってもうちょっと上手く書きたい
      # redirect_to new_managers_foodstuff_path(cuisine_id: @foodstuff.cuisine_id), flash: { error: @foodstuff.errors.full_messages.to_s }
      # binding.pry
      @cuisine = Cuisine.find(@foodstuff.cuisine_id)
      params[:cuisine_id] = @foodstuff.cuisine_id
      render 'new'
    end
  end

  def edit
    @cuisine = Cuisine.find(params[:cuisine_id])
  end

  def update
    if @foodstuff.update(foodstuff_params)
      redirect_to managers_cuisine_path(@foodstuff.cuisine_id), flash: { notice: "変更されました" }
    else
      # HACK: もうちょっと上手い書き方がありそう
      params[:cuisine_id] = @foodstuff.cuisine_id
      render 'edit'
    end
  end

  def destroy
    @foodstuff.destroy
    redirect_to new_managers_foodstuff_path(cuisine_id: @foodstuff.cuisine_id), flash: { notice: "#{@foodstuff.rawmaterial.name} が削除されました" }
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
    @rawmaterials = Rawmaterial.where('name LIKE ? OR hiragana LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%")
    respond_to do |format|
      format.json { render json: @rawmaterials }
    end
  end

  def search_unit
    @unit = Rawmaterial.find_by(id: params[:rm_id])&.unit
    respond_to do |format|
      format.json { render json: @unit }
    end
  end

  def search_foodcategory
    foodcategory_id = Rawmaterial.find_by(id: params[:rm_id]).foodcategory_id
    respond_to do |format|
      format.json { render json: foodcategory_id }
    end
  end

  private

  def set_foodstuff
    @foodstuff = Foodstuff.find(params[:id])
  end

  def foodstuff_params
    params.require(:foodstuff).permit(:id, :quantity, :cuisine_id, :rawmaterial_id, :row_order_position)
  end
end
