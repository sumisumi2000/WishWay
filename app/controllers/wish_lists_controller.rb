class WishListsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @wish_lists = WishList.where(is_public: true)
  end

  def show
    begin
      @user = User.find(params[:id])
    # 存在しない or 非公開のリストにアクセスした際に、一覧ページへリダイレクトする
    rescue ActiveRecord::RecordNotFound
      redirect_to wish_lists_path, notice: 'Wish リストは存在しないか、非公開です'
      return
    end
    @wishes = @user.wish_list.wishes
  end

  def lock
    # ロックするリストをログインユーザーから取得
    wish_list = current_user.wish_list
    # 公開を入れ替え(true なら false、 false なら true)
    wish_list.is_public = !wish_list.is_public
    # データベースに保存
    wish_list.save!
    # リストページにリダイレクト
    redirect_to wish_list_path(wish_list.user)
  end
end
