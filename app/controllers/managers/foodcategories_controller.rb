class Managers::FoodcategoriesController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_foodcategory, only: [:update, :edit, :destroy]

  layout 'manager'
  def index
    @foodcategories = Foodcategory.all
  end

  def new
    @foodcategory = Foodcategory.new
  end

  def create
    @foodcategory = Foodcategory.new(foodcategory_params)
    if @foodcategory.save
      redirect_to managers_foodcategories_path, flash: { notice: "#{@foodcategory.name} が作成されました" }
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @foodcategory.update(foodcategory_params)
      redirect_to managers_foodcategories_path, flash: { notice: "変更されました" }
    else
      # flash.now[:alert] = "aaa"
      render 'edit'
    end
  end

  def destroy
    @foodcategory.destroy
    redirect_to managers_foodcategories_path, flash: { notice: "#{@foodcategory.name} が削除されました" }
  end

  private

  def set_foodcategory
    @foodcategory = Foodcategory.find(params[:id])
  end

  def foodcategory_params
    params.require(:foodcategory).permit(:name)
  end
end
