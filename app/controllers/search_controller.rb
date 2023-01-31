# frozen_string_literal: true

class SearchController < ApplicationController
  def rawmaterial_search
    @rawmaterials = Rawmaterial.where('name LIKE ? OR hiragana LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%")&.limit(5)
    respond_to do |format|
      format.json { render json: @rawmaterials }
    end
  end

  def unit_search
    @unit = Rawmaterial.find_by(id: params[:rm_id])&.unit
    respond_to do |format|
      format.json { render json: @unit }
    end
  end

  def foodcategory_search
    foodcategory_id = Rawmaterial.find_by(id: params[:rm_id]).foodcategory_id
    respond_to do |format|
      format.json { render json: foodcategory_id }
    end
  end
end
