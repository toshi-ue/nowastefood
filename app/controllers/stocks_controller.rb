class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: [:update, :edit, :destroy]
  def index
    @stocks = current_user.stocks.includes(:rawmaterial, { rawmaterial: [:foodcategory, :unit] })
    @todaysmenus = current_user.todaysmenus.includes(:cuisine, cuisine: :foodstuffs).search_in_today
    # stockが全て消費される予定かどうかをbooleanでViewに送る
    stocks_rawmaterial_ids_and_quantites = @stocks.pluck(:rawmaterial_id, :quantity)
    stocks_hash = Hash[stocks_rawmaterial_ids_and_quantites.to_h.map { |key, val| [key, Rational(val)] }]
    # p "aaa"
    # binding.pry
    # 当日のtodayに登録されているcuisineのfoodstuffから
    #   rawmaterial_id, quantityを取得 - (b)
    todaysmenus_rawmaterial_ids_and_quantites = []
    if @todaysmenus.present?
      @todaysmenus.each do |tm|
        c = tm.cuisine
        c.foodstuffs.each_with_index do |fs, _idx|
          todaysmenus_rawmaterial_ids_and_quantites.push([fs.rawmaterial_id, Rational(fs.quantity) * tm.serving_count])
          # p "111"
          # binding.pry
        end
        # p "222"
        # binding.pry
      end

      # rawmaterial_idごとにquantityを集計する - (c)
      tmp_arr = todaysmenus_rawmaterial_ids_and_quantites.group_by do |r|
        r.first
      end
      tmp_arr.each do |k, v|
        tmp_arr[k] = v.inject(0) do |sum, arr|
          sum += Rational(arr.last)
        end
      end
      todaysmenus_hash_after_group_by = tmp_arr
      # p "bbb"
      # (a) - (c) を実行してその結果を stocks_hash に格納する - (d)
      stocks_hash.each do |s_key, _s_value|
        todaysmenus_hash_after_group_by.each do |t_key, _t_value|
          stocks_hash[s_key] = stocks_hash[s_key] - todaysmenus_hash_after_group_by[t_key] if s_key == t_key
          next unless stocks_hash[s_key].negative?

          stocks_hash.delete(s_key)
          break
        end
        break if stocks_hash.empty?
      end
    end

    @stocks_not_plan_to_consume = stocks_hash
    binding.pry
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

  # 賞味期限間近の食材を使い切ることができるCuisineを取得、Todayに追加する
  def auto_today_create
    # binding.pry
    rawmaterial_id_want_to_consume = params[:stock_should_consumed][0]
    quantity_want_to_consume = params[:stock_should_consumed][1]
    foodstuffs_ids = Foodstuff.where(rawmaterial_id: rawmaterial_id_want_to_consume).pluck(:id)
    cuisine_ids = Foodstuff.where(id: foodstuffs_ids).pluck(:cuisine_id)
    # aaa if cuisine_ids.present?
    @cuisines = Cuisine.where(id: cuisine_ids).select(:id).distinct
    # binding.pry
    # quantity_want_to_consume と cuisine.foodstuff.quantity * userのdefault_serving_count を比較
    # 負の整数で値が小さい(なければ正の整数で値が小さい)Cuisineを取得
    arr_cuisine_and_quantity = [] # cuisine_idと消費されるquantityの配列
    @cuisines.each do |c|
      quantity_per_person = Foodstuff.find_by(cuisine_id: c.id, rawmaterial_id: rawmaterial_id_want_to_consume).quantity
      quantity_result_substraction = Rational(quantity_want_to_consume) - Rational(quantity_per_person) * current_user.default_serving_count
      arr_cuisine_and_quantity.push([c.id, quantity_result_substraction])
    end

    # p arr_cuisine_and_quantity
    # binding.pry
    # 負の整数で値が小さい(なければ正の整数で値が小さい)Cuisineを取得
    plus_min_value = nil # 最初のstockをできる限り消費するcuisine_idとquantityの配列
    minus_min_value = nil # 最初のstockを全部消費するcuisine_idとquantityの配列
    arr_cuisine_and_quantity.each do |arr|
      if arr[1].positive?
        if plus_min_value.nil?
          plus_min_value = arr
          # puts "d"
        elsif arr[1] < plus_min_value[1]
          plus_min_value = arr
          # puts "e"
        end
        # binding.pry
      else
        if minus_min_value.nil?
          minus_min_value = arr
          # puts "f"
        elsif arr[1] > minus_min_value[1]
          minus_min_value = arr
          # puts "g"
        end
        # binding.pry
      end
    end
    # p plus_min_value
    # p minus_min_value
    # binding.pry
    # TODO: todayに該当するcuisine(id: minus_min_value[0])を追加する
    @todaysmenu = current_user.todaysmenus.build(cuisine_id: minus_min_value[0], serving_count: current_user.default_serving_count)

    if @todaysmenu.save
      redirect_to todaysmenus_path, flash: { notice: "エコ機能で#{@todaysmenu.cuisine.name}が追加されました" }
    else
      redirect_to todaysmenus_path, flash: { notice: "変更されました" }
    end
    # puts "zzz"
    # binding.pry
    # if current_user.subscribed?
    #   # TODO: 履歴と重複しないCuisineを取得(期間は未定)
    # else
    #   # @cuisines1 = Cuisine.includes(:rawmaterial).where(rawmaterial_id: wants_to_consume_rawmaterial_ids.first)
    #   binding.pry
    # end
    # binding.pry
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
