namespace :notification do
  desc '通知が必要なユーザーにメールを送信'
  task notification_mail: :environment do
    # スコープを使用して通知が必要なユーザーを取得
    users = User.required_notification
    # 各ユーザーにメールを送信
    users.each do |user|
      UserMailer.notification_email(user).deliver_now
    end
  end
end
