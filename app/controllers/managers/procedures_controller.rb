class Managers::ProceduresController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_procedure, only: [:edit, :update, :destroy]

  # TODO: もう少しDRYに書けないか?
  def index
    @cuisine = Cuisine.find(params[:id])
    @procedures = Procedure.where(cuisine_id: params[:id]).rank(:row_order)
    @procedure = Procedure.new(cuisine_id: params[:id])
  end

  def create
    @procedure = Procedure.new(procedure_params)
    @procedure.save
    redirect_to managers_cuisine_path(@procedure.cuisine_id), flash: { notice: "調理の手順が追加されました"}
    # @procedures = Procedure.where(cuisine_id: @procedure.cuisine_id).rank(:row_order)
    # @procedure = Procedure.new(cuisine_id: params[:id])
  end

  def edit; end

  def update
    if @procedure.update(procedure_params)
      @procedures = Procedure.where(cuisine_id: @procedure.cuisine_id).rank(:row_order)
      @procedure = Procedure.new(cuisine_id: params[:id])
    end
    # @procedures = Procedure.where(cuisine_id: @procedure.cuisine_id).rank(:row_order)
    # @procedure = Procedure.new(cuisine_id: params[:id])
  end

  def destroy
    @procedure.destroy
    redirect_to managers_cuisine_path(@procedure.cuisine_id), flash: { notice: "調理の手順が削除されました"}
    # @procedures = Procedure.where(cuisine_id: @procedure.cuisine_id).rank(:row_order)
    # @procedure = Procedure.new(cuisine_id: params[:id])
  end

  def sort
    @procedure = Procedure.find(params[:id])
    @procedure.update(procedure_params)
    head :ok
  end

  private

  def set_procedure
    @procedure = Procedure.find(params[:id])
  end

  def procedure_params
    params.require(:procedure).permit(:cooking_detail, :cuisine_id, :row_order_position)
  end
end
