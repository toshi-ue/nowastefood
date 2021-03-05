class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def create
    current_user.join_subscription
    redirect_to user_subscription_path, flash: { notice: "有料プランの登録が完了しました" }
  end

  def destroy
    current_user.stop_subscription
    redirect_to user_subscription_path, flash: { notice: "有料プランを解除しました" }
  end

  def toggle
    if current_user.subscribed?
      current_user.stop_subscription
      redirect_to cookinghistorys_path, flash: { notice: "無料プランに変更しました" }
    else
      current_user.join_subscription
      redirect_to cookinghistorys_path, flash: { notice: "有料プランに変更しました" }
    end
  end
end
