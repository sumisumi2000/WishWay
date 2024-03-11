class WishListsController < ApplicationController

  def show
    user = User.find(current_user.id)
    @wishes = user.wish_list.wishes
  end
end
