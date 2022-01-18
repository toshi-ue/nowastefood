# frozen_string_literal: true

class Managers::RawmaterialsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_rawmaterial, only: [:edit, :update, :destroy]
  layout 'manager'
  KAMINARI_PAGINATION_COUNT = 13

  def index
    @q = Rawmaterial.includes(:foodcategory).ransack(params[:q])
    @rawmaterials = @q.result.page(params[:page]).per(KAMINARI_PAGINATION_COUNT)
  end

  def new
    @rawmaterial = Rawmaterial.new
  end

  def create
    @rawmaterial = Rawmaterial.new(rawmaterial_params)
    if @rawmaterial.save
      redirect_to managers_rawmaterials_path, flash: { notice: "食材区分 #{@rawmaterial.name} が作成されました" }
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @rawmaterial.update(rawmaterial_params)
      redirect_to managers_rawmaterials_path, flash: { notice: "変更されました" }
    else
      render 'edit'
    end
  end

  def destroy
    @rawmaterial&.destroy
    redirect_to managers_rawmaterials_path, flash: { notice: "原材料 #{@rawmaterial.name} が削除されました" }
  end

  private

  def set_rawmaterial
    @rawmaterial = Rawmaterial.find(params[:id])
  end

  def rawmaterial_params
    params.require(:rawmaterial).permit(:name, :hiragana, :unit_id, :foodcategory_id, :expiry_period, :user_id)
  end
end
