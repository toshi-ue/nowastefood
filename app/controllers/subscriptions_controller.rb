class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  # 処理がなくても動作する
  #   処理がない場合は書かない方が良いのか?
  # def show; end

  def create
    current_user.join_subscription
    redirect_to user_subscription_path, flash: { notice: "有料プランの登録が完了しました" }
  end

  def destroy
    current_user.stop_subscription
    redirect_to user_subscription_path, flash: { notice: "有料プランを解除しました" }
  end
end
