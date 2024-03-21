class WishListsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @wish_lists = WishList.where(is_public: true)
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
  @wishes = @wish_list.wishes
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
end
