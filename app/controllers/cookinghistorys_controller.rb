class CookinghistorysController < ApplicationController
  before_action :authenticate_user!

  def index
    @cookinghistorys = if current_user.subscribed
                         current_user.todaysmenus
                       else
                         current_user.todaysmenus.where(created_at: Time.zone.now.ago(3.days).beginning_of_day..Time.zone.now.end_of_day)
                       end
  end
end
