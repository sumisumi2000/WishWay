class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ログイン状態に移行
      auto_login(@user)
      redirect_to root_path, notice: 'ユーザー作成に成功しました'
    else
      flash.now[:alert] = "ユーザー作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end