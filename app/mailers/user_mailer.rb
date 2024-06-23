class UserMailer < ApplicationMailer
  default from: 'no-reply@wishway.com'

  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email, subject: "[WishWay]パスワードリセット再設定の案内")
  end

  def notification_email(user)
    @user = User.find(user.id)
    # マイリストページへのリンク
    @url = wish_list_url(@user.id)
    # 現在の時刻からリストの作成日の差を計算する
    # 得られる値の単位は秒なので、月に単位を変換する
    @time = ((Time.current - @user.wish_list.created_at) / 3600 / 24 / 30).ceil
    mail(to: user.email, subject: "[WishWay]定期通知のお知らせ")
  end
end
