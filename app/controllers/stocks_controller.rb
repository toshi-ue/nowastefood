class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: [:update, :edit, :destroy]

  def index
    @stocks_not_plan_to_consume = {}
    @stocks = current_user.stocks.includes(:rawmaterial, { rawmaterial: [:foodcategory, :unit] })
    @todaysmenus = current_user.todaysmenus.includes(:cuisine, cuisine: :foodstuffs).search_in_today

    if @todaysmenus.present?
      stocks = Hash[@stocks.pluck(:rawmaterial_id, :quantity).to_h.map { |key, val| [key, Rational(val)] }]
      todaysmenus = @todaysmenus.create_hash_todaysmenus(@todaysmenus)
      stocks_results = @stocks.remaining_amount(stocks, todaysmenus)
    end

    # 残るstocksがある場合は@stocks_not_plan_to_consumeに値が格納されている
    @stocks_not_plan_to_consume = stocks_results if stocks_results
  end

  def show; end

  def new
    @stock = Stock.new
    @rawmaterials = Rawmaterial.all
  end

  def create
    @stock = Stock.new(stock_params)
    @duplicated_stock = current_user.stocks.find_by(rawmaterial_id: @stock.rawmaterial_id)
    if @duplicated_stock
      flash.now[:error] = "すでにstockされている食材は登録できません"
      @rawmaterials = Rawmaterial.all
      return render 'new'
    end
    if @stock.save
      redirect_to stocks_path, flash: { notice: "#{@stock.rawmaterial.name} を追加されました" }
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

    @foodstuffs = Foodstuff.where(rawmaterial_id: rawmaterial_want_to_consume)
    cuisine_ids = current_user.todaysmenus.pluck(:cuisine_id)
    # if @foodstuffs.present?
    # foodstuffsがnilのときの場合どうするかのコードが書いていない(redirect_to が妥当?)
    optimal_cuisine_id = @foodstuffs.best_cuisine(@foodstuffs, cuisine_ids, quantity_want_to_consume, current_user.default_serving_count)

    @todaysmenu = current_user.todaysmenus.build(cuisine_id: optimal_cuisine_id, serving_count: current_user.default_serving_count)

    if @todaysmenu.save
      redirect_to todaysmenus_path, flash: { notice: "エコ機能で#{@todaysmenu.cuisine.name}が追加されました" }
    else
      redirect_to todaysmenus_path, flash: { notice: "変更されました" }
    end
  end

  def search_rawmaterial
    @rawmaterials = Rawmaterial.where('name LIKE ? OR hiragana LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%")
    respond_to do |format|
      format.json { render json: @rawmaterials }
    end
  end

  def unit_search
    @unit = Rawmaterial.find_by(id: params[:rm_id])&.unit
    respond_to do |format|
      format.json { render json: @unit }
    end
  end

  private

  def set_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:quantity, :rawmaterial_id).merge(user_id: current_user.id)
  end
end
