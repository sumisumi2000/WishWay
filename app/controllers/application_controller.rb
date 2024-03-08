class ApplicationController < ActionController::Base
  before_action :require_login

  private
  def not_authenticated
    redirect_to login_path, alert: "ログインが必要です"
  end
end
