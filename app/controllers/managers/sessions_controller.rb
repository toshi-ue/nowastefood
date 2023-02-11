# frozen_string_literal: true

class Managers::SessionsController < Devise::SessionsController
  layout 'manager_sign_in'
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(_resource)
    managers_dashboard_path
  end

  def after_sign_out_path_for(_resource)
    new_manager_session_path
  end

  def login_as_guest_manager
    guest_manager = Manager.create_account_as_guest
    sign_in guest_manager
    redirect_to managers_dashboard_path, notice: "#{guest_manager.name}としてログインしました"
  end
end
