# frozen_string_literal: true

class Managers::ProceduresController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_procedure, only: [:edit, :update, :destroy]
  layout 'manager'

  def new
    @procedure = Procedure.new
    set_cuisine_and_registerd_pds
  end

  def edit
    set_cuisine_and_registerd_pds
  end

  def create
    @procedure = Procedure.new(procedure_params)
    if @procedure.save
      redirect_to new_managers_procedure_path(cuisine_id: @procedure.cuisine_id), flash: { notice: "手順が追加されました" }
    else
      params[:cuisine_id] = @procedure.cuisine_id
      set_cuisine_and_registerd_pds
      render "new"
    end
  end

  def update
    if @procedure.update(procedure_params)
      redirect_to new_managers_procedure_path(cuisine_id: @procedure.cuisine_id), flash: { notice: "更新されました" }
    else
      set_cuisine_and_registerd_pds
      render 'edit'
    end
  end

  def destroy
    @procedure.destroy
    case params[:action_name]
    when "new", "edit"
      redirect_to new_managers_procedure_path(cuisine_id: @procedure.cuisine_id), flash: { notice: "削除しました" }
    when "show"
      redirect_to managers_cuisine_path(@procedure.cuisine_id), flash: { notice: "手順を削除しました" }
    end
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

  def set_cuisine_and_registerd_pds
    @cuisine = Cuisine.find(params[:cuisine_id])
    @registered_procedures = Procedure.where(cuisine_id: params[:cuisine_id]).rank(:row_order)
  end

  def procedure_params
    params.require(:procedure).permit(:cooking_detail, :cuisine_id, :row_order_position)
  end
end
