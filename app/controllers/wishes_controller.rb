class WishesController < ApplicationController
  def new
    @wish = Wish.new
  end

  def create
    # ログインユーザーの WishList に Wish を作成
    wish = current_user.wish_list.wishes.build(wish_params)
    if wish.save
      # マイリストページに遷移
      redirect_to wish_list_path(current_user.id), notice: 'Wish を作成しました'
    else
      flash.now[:alert] = "Wish が作成できませんでした"
      # 新規登録ページを再表示
      render :new, status: :unprocessable_entity
    end
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

    # if @wish.update(wish_params)
    #   redirect_to wish_list_path(@wish.wish_list.user), notice: 'Wish を更新しました'
    # else
    #   # 変更前の値に戻す
    #   @wish.update(@wish.attributes_in_database)
    #   flash.now[:alert] = 'Wish の更新に失敗しました'
    #   render :edit, status: :unprocessable_entity
    # end
  end

  def destroy
    # 更新する Wish をログインユーザーから取得
    wish = current_user.wish_list.wishes.find(params[:id])
    # 削除
    wish.destroy!
    # 削除後、掲示板一覧ページにリダイレクト
    redirect_to wish_list_path(wish.wish_list.user), notice: 'Wish を削除しました', status: :see_other
  end

  def check
    # チェックされたWish をログインユーザーから取得
    @wish = current_user.wish_list.wishes.find(params[:id])
    # チェックする
    @wish.granted = true
    # データベースに保存
    @wish.save!
  end

  def uncheck
    # チェックされたWish をログインユーザーから取得
    @wish = current_user.wish_list.wishes.find(params[:id])
    # チェックを外す
    @wish.granted = false
    # データベースに保存
    @wish.save!
  end

  private

  def wish_params
    params.require(:wish).permit(:title)
  end
end
