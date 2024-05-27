class UserMailer < ApplicationMailer
  default from: 'no-reply@wishway.com'

  def reset_password_email(user)
    @user = User.find(user.id)
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email, subject: "[WishWay]パスワードリセット再設定の案内")
  end
end
