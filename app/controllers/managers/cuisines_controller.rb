class Managers::CuisinesController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_cuisine, only: [:update, :edit, :destroy, :restore]

  layout 'manager'
  def index
    @cuisines = Cuisine.all
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to managers_cuisines_path, flash: { notice: "#{@cuisine.name} が作成されました" }
      # redirect_to new_managers_foodstuff_path(cuisine_id: @cuisine.id), flash: { notice: "#{@cuisine.name} が作成されました" }
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @cuisine.update(cuisine_params)
      redirect_to managers_cuisines_path, flash: { notice: "変更されました" }
    else
      # flash.now[:alert] = "aaa"
      render 'edit'
    end
  end

  def destroy
    @cuisine.discard
    redirect_to managers_cuisines_path, flash: { notice: "#{@cuisine.name} が削除されました" }
  end

  def restore
    @cuisine.undiscard
    redirect_to managers_cuisines_path, flash: { notice: "#{@cuisine.name} が復元されました" }
  end

  private

  def set_cuisine
    @cuisine = Cuisine.find(params[:id])
  end

  def cuisine_params
    params.require(:cuisine).permit(:name, :difficulty, :calories, :cooking_time, :main_image, :discarded_at)
  end
end