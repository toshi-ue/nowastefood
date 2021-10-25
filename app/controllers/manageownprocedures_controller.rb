class ManageownproceduresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_procedure, only: [:edit, :update]

  def new
    @cuisine = Cuisine.find(params[:cuisine_id])
    @foodstuffs = Foodstuff.includes(rawmaterial: :unit).where(cuisine_id: params[:cuisine_id])
    @procedures = Procedure.where(cuisine_id: params[:cuisine_id])
    @procedure = Procedure.new
  end

  def create
    @procedure = Procedure.new(procedure_params)
    if @procedure.save
      redirect_to new_manageownprocedure_path(cuisine_id: @procedure.cuisine_id), flash: { notice: "手順が追加されました" }
    else
      @cuisine = Cuisine.find(@procedure.cuisine_id)
      @procedures = Procedure.where(cuisine_id: @cuisine.id)
      render 'new'
    end
  end

  def edit
    @cuisine = Cuisine.find(@procedure.cuisine_id)
    @procedures = Procedure.where(cuisine_id: @cuisine.id)
    @foodstuffs = Foodstuff.includes(rawmaterial: :unit).where(cuisine_id: @cuisine.id).where.not(params[:id])
  end

  def update
    if @procedure.update(procedure_params)
      redirect_to new_manageownprocedure_path(cuisine_id: @procedure.cuisine_id), flash: { notice: "変更されました" }
    else
      @cuisine = Cuisine.find(@procedure.cuisine_id)
      @foodstuffs = Foodstuff.includes(rawmaterial: :unit).where(cuisine_id: params[:cuisine_id])
      @procedures = Procedure.where(cuisine_id: @cuisine.id)
      params[:cuisine_id] = @procedure.cuisine_id
      render 'edit'
    end
  end

  def destroy
    @procedure = Procedure.find(params[:id])
    @procedure.destroy
    redirect_to new_manageownprocedure_path(cuisine_id: @procedure.cuisine_id), flash: { notice: "手順が1つ削除されました" }
  end

  private

  def set_procedure
    @procedure = Procedure.find(params[:id])
  end

  def procedure_params
    params.require(:procedure).permit(:cooking_detail, :cuisine_id, :row_order_position)
  end
end
