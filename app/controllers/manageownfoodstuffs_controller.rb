# frozen_string_literal: true

class ManageownfoodstuffsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_foodstuff, only: [:edit, :update, :destroy]
  before_action :set_and_check_cuisine, only: [:new, :create, :edit, :update, :destroy]

  def new
    extract_instances(@cuisine)
    @foodstuff = Foodstuff.new
  end

  def edit
    extract_instances(@cuisine)
  end

  def create
    @foodstuff = Foodstuff.new(foodstuff_params)
    if @foodstuff.save
      redirect_to new_manageownfoodstuff_path(cuisine_id: @foodstuff.cuisine_id), flash: { notice: "#{@foodstuff.rawmaterial.name} が追加されました" }
    else
      @cuisine = Cuisine.find(@foodstuff.cuisine_id)
      extract_instances(@cuisine)
      params[:cuisine_id] = @foodstuff.cuisine_id
      render 'new'
    end
  end

  def update
    if @foodstuff.update(foodstuff_params)
      redirect_to new_manageownfoodstuff_path(cuisine_id: @foodstuff.cuisine_id), flash: { notice: "変更されました" }
    else
      @cuisine = Cuisine.find(@foodstuff.cuisine_id)
      extract_instances(@cuisine)
      params[:cuisine_id] = @foodstuff.cuisine_id
      render 'edit'
    end
  end

  def destroy
    @foodstuff.destroy
    redirect_to new_manageownfoodstuff_path(cuisine_id: @foodstuff.cuisine_id), flash: { notice: "#{@foodstuff.rawmaterial.name} が削除されました" }
  end

  private

  def extract_instances(cuisine)
    @foodstuffs = cuisine.foodstuffs.includes(rawmaterial: :unit)
    @procedures = cuisine.procedures
    @rawmaterials = Rawmaterial.all
  end

  def set_and_check_cuisine
    case params[:action].to_sym
    when :new
      @cuisine = Cuisine.find(params[:cuisine_id])
    when :create
      @cuisine = Cuisine.find(params[:foodstuff][:cuisine_id])
    when :edit, :update, :destroy
      @cuisine = Cuisine.find(@foodstuff.cuisine_id)
    end
    check_owner(@cuisine.user, current_user)
  end

  def set_foodstuff
    @foodstuff = Foodstuff.find(params[:id])
  end

  def foodstuff_params
    params.require(:foodstuff).permit(:id, :quantity, :cuisine_id, :rawmaterial_id, :row_order_position)
  end
end
