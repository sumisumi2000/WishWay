class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  # ユーザーをプロバイダーの認証画面に移動させる
  # 認証が終われば callback の url にリダイレクトされる
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    # ログインを試みる
    @user = login_from(provider)

    # Google 認証によるユーザーが存在しない場合
    unless @user
      # プロバイダ情報を取得
      sorcery_fetch_user_hash(provider)

      # 取得したプロバイダ情報のメールアドレスから既存のユーザーを探す
      # シンボルではなく 'email' としているのは返ってくるデータ形式に従ったため
      @user = User.find_by(email: @user_hash[:user_info]['email'])

      # メールアドレスで登録したユーザーが存在する場合
      if @user
        # 既存のユーザーにプロバイダ情報を追加
        @user.add_provider_to_user(provider, @user_hash[:uid].to_s)
      else
        # ユーザーを新規作成
        @user = create_from(provider)
        # ユーザーの WishList を作成
        @user.create_wish_list!(title: "#{@user.name}のバケットリスト")
        # ユーザーの通知データを作成
        @user.create_notification!(is_required: false)
      end

      reset_session
      auto_login(@user)
    end

    redirect_to root_path, notice: "Googleアカウントでログインしました"
  rescue StandardError
    redirect_to root_path, alert: "Google 認証に失敗しました"
  end

  private
  def auth_params
    params.permit(:code, :provider)
  end
end
