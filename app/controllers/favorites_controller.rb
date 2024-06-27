class FavoritesController < ApplicationController
  def create
    @wish_list = WishList.find(params[:wish_list_id])
    current_user.make_favorite(@wish_list)
    flash.now[notice] = 'リストをお気に入りに追加しました'
  end

  def destroy
  end
end
