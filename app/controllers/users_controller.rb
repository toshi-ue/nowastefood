class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update]

  def show; end

  def update
    @user.assign_attributes(user_params)
    if @user.save(context: :update_profile)
      redirect_to user_profile_path, flash: { notice: "プロフィールを更新しました" }
    else
      render 'show'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:nickname, :profile_image, :default_serving_count)
  end
end
