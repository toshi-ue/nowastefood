class FavoritesController < ApplicationController
  # TODO: すぐに不要なコメントアウトを削除
  # ajaxの場合は実行されない?
  before_action :authenticate_user!

  # TODO: セレクトボックスでソート機能を実装するか検討
  def index
    @favorites = current_user.favorites
  end

  # FIXME: あとでAjaxにする
  def create
  end

  def destroy
  end

  private
  # def favorite_params
  #   params.require(:favorite).permit(:user_id, :cuisine_id)
  # end
end
