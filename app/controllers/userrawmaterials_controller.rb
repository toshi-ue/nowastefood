# frozen_string_literal: true

class UserrawmaterialsController < ApplicationController
  before_action :authenticate_user!

  def new
    @rawmaterial = Rawmaterial.new
  end

  def create
    @rawmaterial = Rawmaterial.new(rawmaterial_params)
    respond_to do |format|
      if @rawmaterial.save
        RawmaterialMailer.notify_new_rawmaterial(@rawmaterial).deliver_now
        format.js
        format.json { render json: @rawmaterial, status: :created }
      else
        format.js
        format.json { render json: @rawmaterial.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def rawmaterial_params
    params.require(:rawmaterial).permit(:name, :hiragana, :unit_id, :foodcategory_id, :expiry_period).merge(user_id: current_user.id)
  end
end
