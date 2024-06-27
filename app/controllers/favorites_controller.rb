class FavoritesController < ApplicationController
  helper_method :favorites_page?

  def index
    @q = current_user.favorite_wish_lists.ransack(params[:q])
    @wish_lists = @q.result(distinct: true).includes(:user).where(is_public: true).order('created_at DESC').page(params[:page])
  end

  def create
    @wish_list = WishList.find(params[:wish_list_id])
    current_user.make_favorite(@wish_list)
    flash.now[notice] = 'リストをお気に入りに追加しました'
  end

  def destroy
    @wish_list = WishList.find(params[:id])
    current_user.delete_favorite(@wish_list)
    flash.now[notice] = 'リストをお気に入りから削除しました'
  end

  # オートコンプリート
  def search
    # 入力単語がタイトルに含まれるリストを取得
    @wish_lists = current_user.favorite_wish_lists.where("title like ?", "%#{params[:q]}%").limit(15).order(title: :desc)
    render partial: 'shared/search_result'
  end

  private

  # 遷移元がお気に入り一覧ページかどうかを判定
  def favorites_page?
    request.referer == favorites_url
  end

end
