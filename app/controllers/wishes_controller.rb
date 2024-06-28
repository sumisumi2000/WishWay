class WishesController < ApplicationController
  def create
    # ログインユーザーの WishList を取得
    @wish_list = current_user.wish_list
    # ログインユーザーの WishList に Wish を作成
    @wish = @wish_list.wishes.build(wish_params)
    # データベースに保存
    @wish.save!
    # 達成状況を更新
    @wish_list.update_granted_wish_rate
  end

  def edit
    begin
      # 編集する Wish をログインユーザーから取得
      @wish = current_user.wish_list.wishes.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      # 他のユーザーの Wish 編集ページにアクセスした際に、一覧ページへリダイレクトする
      redirect_to wish_lists_path, notice: '編集権限がありません'
      return
    end
  end

  def update
    # 更新する Wish をログインユーザーから取得
    @wish = current_user.wish_list.wishes.find(params[:id])

    # 更新に失敗した場合は、前の値を渡す
    if !@wish.update(wish_params)
      @wish.update(@wish.attributes_in_database)
    end

    # ログインユーザーの全ての Wish を取得
    @wishes = current_user.wish_list.wishes
  end

  def destroy
    # ログインユーザーの WishList を取得
    @wish_list = current_user.wish_list
    # ログインユーザーの Wish を全て取得
    @wishes = @wish_list.wishes
    # 削除する Wish をログインユーザーから取得
    @wish = @wishes.find(params[:id])
    # 削除
    @wish.destroy!
    # 達成状況を更新
    @wish_list.update_granted_wish_rate
  end

  def check
    # ログインユーザーの WishList を取得
    @wish_list = current_user.wish_list
    # チェックされたWish をログインユーザーから取得
    @wish = @wish_list.wishes.find(params[:id])
    # チェックする
    @wish.granted = true
    # データベースに保存
    @wish.save!
    # 達成状況を更新
    @wish_list.update_granted_wish_rate
  end

  def uncheck
    # ログインユーザーの WishList を取得
    @wish_list = current_user.wish_list
    # チェックされたWish をログインユーザーから取得
    @wish = @wish_list.wishes.find(params[:id])
    # チェックを外す
    @wish.granted = false
    # データベースに保存
    @wish.save!
    # 達成状況を更新
    @wish_list.update_granted_wish_rate
  end

  def add
    # ログインユーザーの WishList を取得
    @wish_list = current_user.wish_list
    # params から wish を取得
    @wish = Wish.find(params[:id])
    # ログインユーザーの wish として新規作成
    @wish_list.wishes.create!(title: @wish.title)
    # 達成状況を更新
    @wish_list.update_granted_wish_rate
    # フラッシュメッセージを登録
    flash.now[:notice] = "マイリストに Wish を作成しました"
  end

  private

  def wish_params
    params.require(:wish).permit(:title)
  end
end
