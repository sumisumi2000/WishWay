class WishListsController < ApplicationController
  skip_before_action :require_login, only: %i[index show search]
  before_action :set_wish_list, only: %i[show]
  before_action :check_list_visibility, only: %i[show]

  def index
    @q = WishList.ransack(params[:q])
    @wish_lists = @q.result(distinct: true).includes(:user).where(is_public: true).order('created_at DESC').page(params[:page])
  end

  def show
    # 新規作成用の Wish を作成
    @wish = Wish.new

    # リストの Wish を取得
    @wishes = @wish_list.wishes.order('created_at ASC')
  end

  def edit
    # 編集する WishList をログインユーザーから取得
    @wish_list = current_user.wish_list
  end

  def update
    # 更新する Wish をログインユーザーから取得
    @wish_list = current_user.wish_list

    # 更新に失敗した場合は、前の値を渡す
    if !@wish_list.update(wish_list_params)
      @wish_list.update(@wish_list.attributes_in_database)
    end

    # ログインユーザーの全ての Wish を取得
    @wishes = @wish_list.wishes
  end

  def destroy
    # 削除する WishList をログインユーザーから取得
    wish_list = current_user.wish_list
    # 削除
    wish_list.destroy!
    # ユーザーの削除
    current_user.destroy!
    # トップページへ戻る
    redirect_to root_path, notice: 'バケットリストとアカウントを削除しました', status: :see_other
  end

  def lock
    # ログインユーザーの WishList を取得
    wish_list = current_user.wish_list
    # 公開に設定
    wish_list.is_public = false
    # データベースに保存
    wish_list.save!
  end

  def unlock
    # ログインユーザーの WishList を取得
    @wish_list = current_user.wish_list
    # 公開に設定
    @wish_list.is_public = true
    # データベースに保存
    @wish_list.save!
  end

  # オートコンプリート
  def search
    # 入力単語がタイトルに含まれるリストを取得
    @wish_lists = WishList.where("title like ?", "%#{params[:q]}%").limit(15).order(title: :desc)
    render partial: 'shared/search_result'
  end

  private

  def wish_list_params
    params.require(:wish_list).permit(:title)
  end

  def set_wish_list
    # params からリスト所持者のユーザーを取得し、リストを取得
    @wish_list = User.find(params[:id]).wish_list

    # 存在しないリストにアクセスした際に、一覧ページへリダイレクト
  rescue ActiveRecord::RecordNotFound
    redirect_to wish_lists_path, notice: 'リストは存在しないか、非公開です'
  end

  def check_list_visibility
    # リストが公開設定なら閲覧可能
    return if @wish_list.is_public

    # 非公開かつマイリストでなければ一覧ページへリダイレクト
    unless current_user&.my_list?(@wish_list)
      redirect_to wish_lists_path, notice: 'リストは存在しないか、非公開です'
    end
  end
end
