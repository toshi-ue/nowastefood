class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update_profile]

  def show; end

  # このアクションでvalidationを実行させたい
  def update_profile
    if @user.update(update_profile_params)
      redirect_to user_profile_path, flash: { notice: "プロフィールを更新しました" }
    else
      redirect_to user_profile_path
    end
  end

  private

  def set_user
    @user = current_user
  end

  def update_profile_params
    params.require(:user).permit(:nickname, :profile_image, :default_serving_count)
  end
end
