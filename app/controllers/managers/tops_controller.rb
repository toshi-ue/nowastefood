# frozen_string_literal: true

class Managers::TopsController < ApplicationController
  before_action :authenticate_manager!
  layout 'manager'

  def dashboard
    @cuisines = Cuisine.all
    @favorites = Favorite.all
    @users = User.all
    @new_users = @users.where(created_at: Time.zone.now.all_day)
    @mau = @users.where(last_sign_in_at: Time.zone.now.all_month)
    @rawmaterials = Rawmaterial.all
  end

  def toggle_editable
    current_manager.toggle_editable!
    redirect_to managers_dashboard_path, flash: { notice: "editableを #{current_manager.editable} に変更しました" }
  end
end
