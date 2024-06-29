class FavoritesController < ApplicationController
  helper_method :favorites_page?

  def index
    # サブクエリを作成して、各 wish_list と favorites.created_at の値を取得
    subquery = current_user.favorite_wish_lists.select('wish_lists.*, MAX(favorites.created_at) as favorites_created_at').where(is_public: true).joins(:favorites).group('wish_lists.id')
    # サブクエリをベースに Ransack のクエリを作成
    @q = WishList.from(subquery, :wish_lists).ransack(params[:q])
    # 最終的なクエリを構築してページング
    @wish_lists = @q.result.includes(:user).order('favorites_created_at DESC').page(params[:page])
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
