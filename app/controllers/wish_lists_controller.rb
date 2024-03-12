class WishListsController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    @wish_lists = WishList.all
  end

  def show
    @user = User.find(params[:id])
    @wishes = @user.wish_list.wishes
  end
end
