class Managers::RawmaterialsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_rawmaterial, only: [ :edit, :update, :destroy, :restore]

  layout 'manager'
  def index
    @rawmaterials = Rawmaterial.includes(:foodcategory)
    # binding.pry
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

  def edit
  end

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

  # TODO: 最後に削除(エラーがなければ)
  # def restore
  #   @rawmaterial.undiscard
  #   redirect_to managers_rawmaterials_path, flash: { notice: "食材区分 #{@rawmaterial.name} が復元されました" }
  # end

  private

  def set_rawmaterial
    @rawmaterial = Rawmaterial.find(params[:id])
  end

  def rawmaterial_params
    params.require(:rawmaterial).permit(:name, :hiragana, :unit_id, :foodcategory_id)
  end
end
