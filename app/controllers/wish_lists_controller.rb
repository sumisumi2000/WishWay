class WishListsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @wish_lists = WishList.where(is_public: true)
  end

  def show
    begin
      @user = User.find(params[:id])
      # リストが非公開の場合、一覧ページにリダイレクト
      unless @user.wish_list.is_public
        redirect_to wish_lists_path, notice: 'このリストは非公開です'
        return
      end
    # 存在しないリストにアクセスした際に、一覧ページへリダイレクトする
    rescue ActiveRecord::RecordNotFound
      redirect_to wish_lists_path, notice: 'このリストは見つかりませんでした'
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
