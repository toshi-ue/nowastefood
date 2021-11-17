# frozen_string_literal: true

class ManageownproceduresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_procedure, only: [:edit, :update, :destroy]
  before_action :set_and_check_cuisine, only: [:new, :create, :edit, :update, :destroy]

  def new
    extract_instances(@cuisine)
    @procedure = Procedure.new
  end

  def create
    @procedure = Procedure.new(procedure_params)
    if @procedure.save
      redirect_to new_manageownprocedure_path(cuisine_id: @procedure.cuisine_id), flash: { notice: "手順が追加されました" }
    else
      @cuisine = Cuisine.find(@procedure.cuisine_id)
      extract_instances(@cuisine)
      render 'new'
    end
  end

  def edit
    extract_instances(@cuisine)
  end

  def update
    if @procedure.update(procedure_params)
      redirect_to new_manageownprocedure_path(cuisine_id: @procedure.cuisine_id), flash: { notice: "変更されました" }
    else
      @cuisine = Cuisine.find(@procedure.cuisine_id)
      extract_instances(@cuisine)
      params[:cuisine_id] = @procedure.cuisine_id
      render 'edit'
    end
  end

  def destroy
    @procedure.destroy
    redirect_to new_manageownprocedure_path(cuisine_id: @procedure.cuisine_id), flash: { notice: "手順が1つ削除されました" }
  end

  private

  def extract_instances(cuisine)
    @foodstuffs = cuisine.foodstuffs.includes(rawmaterial: :unit)
    @procedures = cuisine.procedures
  end

  def set_and_check_cuisine
    case params[:action].to_sym
    when :new
      @cuisine = Cuisine.find(params[:cuisine_id])
    when :create
      @cuisine = Cuisine.find(params[:procedure][:cuisine_id])
    when :edit, :update, :destroy
      @cuisine = Cuisine.find(@procedure.cuisine_id)
    end
    check_owner(@cuisine.user, current_user)
  end

  def set_procedure
    @procedure = Procedure.find(params[:id])
  end

  def procedure_params
    params.require(:procedure).permit(:cooking_detail, :cuisine_id, :row_order_position)
  end
end
