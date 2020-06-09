class Managers::CookedstatesController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_cookedstate, only: [:update, :edit, :destroy, :restore]

  layout 'manager'
  def index
    @cookedstates = Cookedstate.includes(:foodcategory)
  end

  def new
    @cookedstate = Cookedstate.new
  end

  def create
    @cookedstate = Cookedstate.new(cookedstate_params)
    if @cookedstate.save
      redirect_to managers_cookedstates_path, flash: { notice: "#{@cookedstate.name} が登録されました" }
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @cookedstate.update(cookedstate_params)
      redirect_to managers_cookedstates_path, flash: { notice: "変更されました" }
    else
      render 'edit'
    end
  end

  def destroy
    @cookedstate.discard
    redirect_to managers_cookedstates_path, flash: { notice: "#{@cookedstate.name} が削除されました" }
  end

  def restore
    @cookedstate.undiscard
    redirect_to managers_cookedstates_path, flash: { notice: "#{@cookedstate.name} が復元されました" }
  end

  private

  def set_cookedstate
    @cookedstate = Cookedstate.find(params[:id])
  end

  def cookedstate_params
    params.require(:cookedstate).permit(:name, :foodcategory_id, :discarded_at)
  end
end
