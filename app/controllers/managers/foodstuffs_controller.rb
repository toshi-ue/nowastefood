class Managers::FoodstuffsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_foodstuff, only: [:update, :edit, :destroy, :restore]

  layout 'manager'
  def index
    @foodstuffs = Foodstuff.includes(:cookedstate, :cuisine, :ingredient, :rawmaterial)
  end

  def new
    @foodstuff = Foodstuff.new
  end

  def create
    @foodstuff = Foodstuff.new(foodstuff_params)
    if @foodstuff.save
      redirect_to managers_foodstuffs_path, flash: { notice: "#{@foodstuff.quantity} が追加されました" }
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @foodstuff.update(foodstuff_params)
      redirect_to managers_foodstuffs_path, flash: { notice: "変更されました" }
    else
      # flash.now[:alert] = "aaa"
      render 'edit'
    end
  end

  def destroy
    @foodstuff.destroy
    redirect_to managers_foodstuffs_path, flash: { notice: "#{@foodstuff.name} が削除されました" }
  end

  def restore
    @foodstuff.undiscard
    redirect_to managers_foodstuffs_path, flash: { notice: "#{@foodstuff} が復元されました" }
  end

  private

  def set_foodstuff
    @foodstuff = Foodstuff.find(params[:id])
  end

  def foodstuff_params
    params.require(:foodstuff).permit(:id, :quantity, :measure_unit, :cuisine_id, :rawmaterial_id, :ingredient_id, :cookedstate_id, :discarded_at)
  end
end
