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
    @wish = current_user.wish_list.wishes.find(params[:id])
  end

  private

  def wish_params
    params.require(:wish).permit(:title)
  end
end
