# frozen_string_literal: true

class PasswordsController < ApplicationController
  before_action :set_user, only: %i[edit update]
  def edit; end

  def update
    if current_user.update_with_password(user_params)
      bypass_sign_in(current_user)
      # sign_in(current_user, bypass: true)
      redirect_to edit_password_path, flash: { notice: 'パスワードを更新しました' }
    else
      set_user
      render 'edit'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
