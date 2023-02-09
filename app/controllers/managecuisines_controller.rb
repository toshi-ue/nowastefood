# frozen_string_literal: true

class ManagecuisinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cuisine, only: %i[show edit update destroy]
  before_action :check_cuisine_owner, only: %i[show edit update destroy]

  def index
    @cuisines = current_user.owner_cuisines
  end

  def show
    @foodstuffs = @cuisine.foodstuffs.includes(:rawmaterial, { rawmaterial: :unit })
    @procedures = @cuisine.procedures
  end

  def new
    @cuisine = Cuisine.new
  end

  def edit; end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to managecuisine_path(@cuisine), flash: { notice: "#{@cuisine.name}が作成されました" }
    else
      render 'new'
    end
  end

  def update
    if @cuisine.update(cuisine_params)
      redirect_to managecuisine_path(@cuisine), flash: { notice: '更新されました' }
    else
      render 'edit'
    end
  end

  def destroy
    @cuisine.destroy
    redirect_to managecuisines_path, flash: { notice: "#{@cuisine.name} のレシピが削除されました" }
  end

  def toggle_status
    @cuisine = Cuisine.find(params[:managecuisine_id])
    @cuisine.toggle_status!
    redirect_to managecuisine_path(@cuisine), flash: { notice: "#{@cuisine.name}が #{@cuisine.status_i18n} になりました" }
  end

  private

  def set_cuisine
    @cuisine = Cuisine.find(params[:id])
  end

  def check_cuisine_owner
    check_owner(@cuisine.user, current_user)
  end

  def cuisine_params
    params.require(:cuisine).permit(:name, :genre, :calories, :cooking_time, :description, :main_image, :status).merge(user_id: current_user.id)
  end
end
