class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: [:update, :edit, :destroy]

  def index
    @stocks = current_user.stocks.includes(:rawmaterial, { rawmaterial: :unit }).unused.order(rotted_at: 'ASC')
    @todaysmenus = current_user.todaysmenus.includes(:cuisine, cuisine: :foodstuffs).not_cooked.search_in_today
    @rawmaterials_and_quantity_will_be_consumed = @todaysmenus.get_quantities_grouped_by_rawmaterial(todaysmenus: @todaysmenus)
  end

  def show; end

  def new
    @stock = Stock.new
    @rawmaterials = Rawmaterial.all
  end

  def create
    @stock = Stock.new(stock_params)
    @stock.store_default_values if params[:rawmaterial_id].present?
    if @stock.save
      redirect_to stocks_path, flash: { notice: "#{@stock.rawmaterial.name} を追加しました" }
    else
      @rawmaterials = Rawmaterial.all
      render 'new'
    end
  end

  def edit; end

  def update
    if @stock.update(stock_params)
    end
  end

  def destroy
    @stock.destroy
    redirect_to stocks_path, flash: { notice: "#{@stock.rawmaterial.name}を削除しました" }
  end

  # 賞味期限間近の食材を使い切ることができるCuisineを取得、Todayに追加する
  def auto_today_create
    rawmaterial_want_to_consume = params[:stock_should_consumed][0].to_i
    quantity_want_to_consume = params[:stock_should_consumed][1]

    @foodstuffs = Foodstuff.includes(:rawmaterial).where(rawmaterial_id: rawmaterial_want_to_consume)
    cuisine_ids = current_user.todaysmenus.pluck(:cuisine_id)
    optimal_cuisine_id = @foodstuffs.best_cuisine(@foodstuffs, cuisine_ids, quantity_want_to_consume, current_user.default_serving_count)

    @todaysmenu = current_user.todaysmenus.build(cuisine_id: optimal_cuisine_id, serving_count: current_user.default_serving_count)

    if @todaysmenu.save
      redirect_to todaysmenus_path, flash: { notice: "エコ機能で#{@todaysmenu.cuisine.name}が追加されました" }
    else
      redirect_to todaysmenus_path, flash: { notice: "変更されました" }
    end
  end

  def search_rawmaterial
    @rawmaterials = Rawmaterial.where('name LIKE ? OR hiragana LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%").where.not(foodcategory_id: 4)
    respond_to do |format|
      format.json { render json: @rawmaterials }
    end
  end

  def search_unit_and_expiry_period
    @rawmaterial = Rawmaterial.includes(:unit).find_by(id: params[:id])
    respond_to do |format|
      format.json { render json: { expiry_period: @rawmaterial.expiry_period, unit_name: @rawmaterial.unit.name } }
    end
  end

  private

  def set_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:quantity, :rawmaterial_id, :rotted_at, :consumed_at, :abandoned_at).merge(user_id: current_user.id)
  end
end
