class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :redirect_if_authenticated, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザーの WishList を作成
      @user.create_wish_list!(title: "#{@user.name}のバケットリスト")
      # ユーザーの通知データを作成
      @user.create_notification!(is_required: false)
      # ログイン状態に移行
      auto_login(@user)
      # マイリストページに遷移
      redirect_to wish_list_path(@user.id), notice: 'ユーザー作成に成功しました'
    else
      flash.now[:alert] = "ユーザー作成に失敗しました"
      # 新規登録ページを再表示
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if user_params[:name].blank?
      # TODO : ユーザー名が空の場合のフラッシュメッセージ
      render :edit, status: :unprocessable_entity
    elsif current_user.update(user_params)
      # TODO : ユーザー名の変更に成功した場合のフラッシュメッセージ
    end
  end

  private

  # Only allow a list of trusted parameters through
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
