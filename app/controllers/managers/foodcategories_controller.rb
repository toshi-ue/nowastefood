class Managers::FoodcategoriesController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_foodcategory, only: [:update, :edit, :destroy, :restore]

  layout 'manager'
  def index
    @foodcategories = Foodcategory.all
  end

  def new
    @foodcategory = Foodcategory.new
  end

  def create
    @foodcategory = Foodcategory.new(foodcategory_params)
    # @foodcategory.discarded_at = INITIAL_TIME
    if @foodcategory.save
      redirect_to managers_foodcategories_path, flash: { notice: "食材区分 #{@foodcategory.name} が作成されました" }
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
    @foodcategory.discard
    redirect_to managers_foodcategories_path, flash: { notice: "食材区分 #{@foodcategory.name} が削除されました" }
  end

  def restore
    @foodcategory.undiscard
    redirect_to managers_foodcategories_path, flash: { notice: "食材区分 #{@foodcategory.name} が復元されました" }
  end

  private

  def set_foodcategory
    @foodcategory = Foodcategory.find(params[:id])
  end

  def foodcategory_params
    params.require(:foodcategory).permit(:name, :discarded_at).merge(manager_id: current_manager.id)
  end
end
