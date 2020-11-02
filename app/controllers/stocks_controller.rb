class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: [:update, :edit, :destroy]
  def index
    @stocks = Stock.includes(:rawmaterial, { rawmaterial: [:foodcategory, :unit] }).where(user_id: current_user.id)
  end

  # def show; end

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

  def auto_today_create
    # ユーザーのstocksを取得
    @stocks = current_user.stocks.order(created_at: "ASC")
    # 前準備(賞味期限間近の食材を使用できるCuisineを取得する)
    rawmaterial_id_best_before = @stocks.first.rawmaterial_id
    quantity_best_before = @stocks.first.quantity
    foodstuffs_ids = Foodstuff.where(rawmaterial_id: rawmaterial_id_best_before).pluck(:id)
    cuisine_ids = Foodstuff.where(id: foodstuffs_ids).pluck(:cuisine_id)
    # 前準備で作成した変数を使用して検索(賞味期限間近の食材を使用できるCuisineを取得する)
    @cuisines = Cuisine.where(id: cuisine_ids).select(:id).distinct
    # quantity_best_before と cuisine.foodstuff.quantity * userのdefault_serving_count を比較
    # 負の整数で値が小さい(なければ正の整数で値が小さい)Cuisineを取得
    quantity_differences = []
    @cuisines.each do |c|
      quantity_differences.push(c.aaa(quantity_best_before, c.id, rawmaterial_id_best_before, current_user.default_serving_count))
    end

    p quantity_differences
    min_index = -1
    positive_value_close_to_zero = nil
    negative_value_close_to_zero = nil
    quantity_differences.each_with_index do |qd, _index|
      if qd[1] < 0
        if negative_value_close_to_zero.nil?
          negative_value_close_to_zero = qd
          # puts "a"
        elsif qd[1] > negative_value_close_to_zero[1]
          negative_value_close_to_zero = qd
          # puts "b"
        end
        # puts "c"
        # binding.pry
      else
        if positive_value_close_to_zero.nil?
          positive_value_close_to_zero = qd
          # puts "d"
        elsif qd[1] < positive_value_close_to_zero[1]
          positive_value_close_to_zero = qd
          # puts "e"
        end
        # puts "f"
        # binding.pry
      end
    end
    if negative_value_close_to_zero
      # TODO: todayに該当するcuisine(id: negative_value_close_to_zero[0])を追加する
      @todaysmenu = current_user.todaysmenus.build(cuisine_id: negative_value_close_to_zero[0], serving_count: current_user.default_serving_count)
      @todaysmenu.save
      redirect_to todaysmenus_path
      # puts "yyy"
      # binding.pry
    end
    # puts "zzz"
    # binding.pry
    # if current_user.subscribed?
    #   # TODO: 履歴と重複しないCuisineを取得(期間は未定)
    # else
    #   # @cuisines1 = Cuisine.includes(:rawmaterial).where(rawmaterial_id: wants_to_consume_rawmaterial_ids.first)
    #   binding.pry
    # end
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
