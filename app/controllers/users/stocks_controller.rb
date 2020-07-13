class Users::StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stock, only: [:show, :update, :edit, :destroy]
  def index
    @stocks = Stock.all.where(user_id: prams[:id])
  end

  # def show; end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
    end
  end

  def edit; end

  def update
    if @stock.update(stock_params)
    end
  end

  def destroy
    @stock.destroy
  end

  private

  def set_stock
    @stock = Stock.find(params[:id])
  end

  def stock_params
    params.require(:stock).permit(:quantity, :rawmaterial_id, :user_id)
  end
end
