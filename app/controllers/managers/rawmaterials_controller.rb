class Managers::RawmaterialsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_rawmaterial, only: [:update, :edit, :destroy, :restore]

  layout 'manager'
  def index
    @rawmaterials = Rawmaterial.all
    # binding.pry
  end

  def new
    @rawmaterial = Rawmaterial.new
    @rawmaterial.build_nutrient
  end

  def create
    @rawmaterial = Rawmaterial.new(rawmaterial_params)
    # binding.pry
    if @rawmaterial.save
      # binding.pry
      redirect_to managers_rawmaterials_path, flash: { notice: "食材区分 #{@rawmaterial.name} が作成されました" }
    else
      render 'new'
    end
  end

  def edit
    # @rawmaterial.build_nutrient
  end

  def update
    if @rawmaterial.update(rawmaterial_params)
      p "a"
      binding.pry
      redirect_to managers_rawmaterials_path, flash: { notice: "変更されました" }
    else
      p "b"
      binding.pry
      render 'edit'
    end
  end

  def destroy
    @rawmaterial.discard
    redirect_to managers_rawmaterials_path, flash: { notice: "食材区分 #{@rawmaterial.name} が削除されました" }
  end

  def restore
    @rawmaterial.undiscard
    redirect_to managers_rawmaterials_path, flash: { notice: "食材区分 #{@rawmaterial.name} が復元されました" }
  end

  private

  def set_rawmaterial
    @rawmaterial = Rawmaterial.find(params[:id])
  end

  def rawmaterial_params
    params.require(:rawmaterial).permit(:name, :min_quantity, :foodcategory_id, :discarded_at, nutrient_attributes: [:lipid, :carbonhydrate, :protein, :vit_a, :vit_d, :vit_e, :vit_k, :vit_b1, :vit_b2, :vit_b6, :vit_b12, :vit_c, :potassium, :calcium, :magnesium, :phosphorus, :iron, :zinc, :copper, :manganese, :beta_carotene, :niacin, :folic_acid, :pantothenic_acid])
  end
end
