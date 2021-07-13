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
end
