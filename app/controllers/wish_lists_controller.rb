class WishListsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @wish_lists = WishList.all
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
end
