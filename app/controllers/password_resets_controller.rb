class PasswordResetsController < ApplicationController
  # ログインできないユーザー用
  skip_before_action :require_login

  # パスワードリセット申請フォーム
  def new; end

  # ユーザーが入力したメールアドレスを取得
  def create
    # メールアドレスからユーザーを特定
    @user = User.find_by_email(params[:email])

    # ユーザが見つかれば、トークンを生成し、再設定用のメールを送信
    @user&.deliver_reset_password_instructions!

    # メールアドレスが存在しなくても、フラッシュメッセージは送信（存在していないという情報を与えない）
    redirect_to login_path, notice: 'メールを送信しました'
  end

  # パスワードリセットフォーム
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    # ユーザーがいなければログインページへ遷移
    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    # params に含まれるトークンからユーザを特定
    @user = User.load_from_reset_password_token(params[:id])

    # ユーザが見つからない場合
    if @user.blank?
      # ログイン画面に遷移
      not_authenticated
      return
    end

    # バリデーションチェック
    @user.password_confirmation = password_params[:password_confirmation]
    # トークンをクリアして、パスワードを更新
    if @user.change_password(password_params[:password])
      # ログインページに遷移し、フラッシュメッセージを表示
      redirect_to login_path, notice: 'パスワードを再設定しました'
    else
      # 再設定画面を再表示
      render :edit, status: :unprocessable_entity
    end
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
