class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def create
    current_user.join_subscription
  end

  def destroy
    current_user.cancel_subscription
  end
end
