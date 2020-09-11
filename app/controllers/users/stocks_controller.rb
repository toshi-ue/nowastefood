class Users::StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: [:update, :edit, :destroy]
  def index
    @stocks = Stock.includes(:rawmaterial, { rawmaterial: [:foodcategory, :unit] }).where(user_id: current_user.id)
  end

  # def show; end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)
    @duplicated_stock = Stock.find_by(rawmaterial_id: @stock.rawmaterial_id, user_id: current_user.id)
    if @duplicated_stock
        flash.now[:error] = "すでにstockされている食材は登録できません"
        return render 'new'
    end
    if @stock.save
      redirect_to users_stocks_path, flash: { notice: "#{@stock.rawmaterial.name} を追加されました" }
    else
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
    redirect_to users_stocks_path, flash: { notice: "#{@stock.rawmaterial.name}を削除しました" }
  end

  def search_rawmaterial
    @rawmaterials = Rawmaterial.where('name LIKE ? OR hiragana LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
  end

  private

  def set_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:quantity, :rawmaterial_id, :user_id)
  end
end
