class ApplicationController < ActionController::Base
  before_action :require_login

  private
  def not_authenticated
    redirect_to login_path, alert: "ログインが必要です"
  end

  # ログイン時のアクセス制限
  def redirect_if_authenticated
    # ログインしている時
    if logged_in?
      redirect_to root_path, alert: "すでにログインしています"
    end
  end
end
