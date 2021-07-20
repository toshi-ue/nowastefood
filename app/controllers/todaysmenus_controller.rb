class TodaysmenusController < ApplicationController
  before_action :authenticate_user!
  def index
    @todaysmenus = current_user.todaysmenus.includes(:cuisine).not_cooked
  end

  def update
    @todaysmenu = Todaysmenu.find_by(id: params[:id])
    @todaysmenu.update(todaysmenu_params)
    head :ok
  end

  def destroy
    @todaysmenu = Todaysmenu.find_by(id: params[:id])
    @todaysmenu.destroy
    redirect_to todaysmenus_path, flash: { notice: "#{@todaysmenu.cuisine.name}を削除しました" }
  end

  def cooked_done
    @todaysmenus = current_user.todaysmenus.includes(:cuisine, cuisine: :foodstuffs).not_cooked
    @stocks = current_user.stocks.includes(:rawmaterial, { rawmaterial: :unit }).unused.order(rotted_at: 'ASC')
    @rawmaterials_and_quantity_will_be_consumed = @todaysmenus.get_quantities_grouped_by_rawmaterial(todaysmenus: @todaysmenus)
    @stocks.store_consumed_at(@stocks, @rawmaterials_and_quantity_will_be_consumed)
    @todaysmenus.update_all(cooked_when: params[:cooked_when].to_i)
    flash[:notice] = "#{@todaysmenus.map { |t| t.cuisine.name }.join(' と ')}を料理しました。お疲れ様です!!"
    redirect_to todaysmenus_path
  end

  private

  def todaysmenu_params
    params.require(:todaysmenu).permit(:cuisine_id, :user_id, :serving_count)
  end
end
