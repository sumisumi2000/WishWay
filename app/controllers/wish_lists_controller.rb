class WishListsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @wish_lists = WishList.includes(:user).where(is_public: true)
  end

  def show
    begin
      # 新規作成用の Wish を作成
      @wish = Wish.new

      # params からリスト所持者のユーザーを取得し、リストを取得
      @wish_list = User.find(params[:id]).wish_list

      if !@wish_list.is_public
        # リストが非公開であっても、自分のリストであれば表示
        if current_user.my_list?(@wish_list)
          # リストの Wish を取得
          @wishes = @wish_list.wishes
          return
        end
        # リストが非公開の場合、一覧ページにリダイレクト
        redirect_to wish_lists_path, notice: 'このリストは非公開です'
        return
      end
    # 存在しないリストにアクセスした際に、一覧ページへリダイレクト
    rescue ActiveRecord::RecordNotFound
      redirect_to wish_lists_path, notice: 'このリストは見つかりませんでした'
      return
    end
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

  private

  def wish_list_params
    params.require(:wish_list).permit(:title)
  end
end
