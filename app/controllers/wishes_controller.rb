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

    if @wish.update(wish_params)
      redirect_to(wish_list_path(@wish.wish_list.user), notice: 'Wish を更新しました')
    else
      # 変更前の値に戻す
      @wish.update(@wish.attributes_in_database)
      flash.now[:alert] = 'Wish の更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def wish_params
    params.require(:wish).permit(:title)
  end
end
