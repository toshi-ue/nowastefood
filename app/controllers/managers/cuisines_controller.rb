class Managers::CuisinesController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_cuisine, only: [:show, :update, :edit, :destroy]

  layout 'manager'
  def index
    @cuisines = Cuisine.all
  end

  def show
    # UNKNOWN:
      # cuisineのアソシエーション経由で全情報を取得した方が良いのか?
      # 複数のインスタンスを作成してそれぞれ取得した方がよいのか?
      #   e.g. @cuisine, @foodstuffs, @procedures など

    # UNKNOWN: bulletで警告が発生する
    # See 'Uniform Notifier' in JS Console for Stacktrace×
    # user: root USE eager loading detected Foodstuff => [:rawmaterial] Add to your query: .includes([:rawmaterial])
    # user: root USE eager loading detected Foodstuff => [:unit] Add to your query: .includes([:unit])
    # user: root USE eager loading detected Foodstuff => [:ingredient] Add to your query: .includes([:ingredient])
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to managers_cuisines_path, flash: { notice: "#{@cuisine.name} が作成されました" }
      # redirect_to new_managers_foodstuff_path(cuisine_id: @cuisine.id), flash: { notice: "#{@cuisine.name} が作成されました" }
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @cuisine.update(cuisine_params)
      redirect_to managers_cuisines_path, flash: { notice: "変更されました" }
    else
      # flash.now[:alert] = "aaa"
      render 'edit'
    end
  end

  def destroy
    @cuisine.discard
    redirect_to managers_cuisines_path, flash: { notice: "#{@cuisine.name} が削除されました" }
  end

  private

  def set_cuisine
    @cuisine = Cuisine.find(params[:id])
  end

  def cuisine_params
    params.require(:cuisine).permit(:name, :difficulty, :calories, :cooking_time, :main_image, :discarded_at)
  end
end
