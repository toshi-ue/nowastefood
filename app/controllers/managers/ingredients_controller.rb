class Managers::IngredientsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_ingredient, only: [:update, :edit, :destroy, :restore]
  layout 'manager'

  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    if @ingredient.save
      redirect_to managers_ingredients_path, flash: { notice: "部位名 #{@ingredient.name} が作成されました" }
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to managers_ingredients_path, flash: { notice: "変更されました" }
    else
      # flash.now[:alert] = "aaa"
      render 'edit'
    end
  end

  def destroy
    @ingredient.discard
    redirect_to managers_ingredients_path, flash: { notice: "部位名 #{@ingredient.name} が削除されました" }
  end

  def restore
    @ingredient.undiscard
    redirect_to managers_ingredients_path, flash: { notice: "部位名 #{@ingredient.name} が復元されました" }
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :discarded_at)
  end
end
