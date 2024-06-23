class NotificationsController < ApplicationController
  def update
    # 通知の有無を更新
    current_user.notification.update(settings_params)
    redirect_to user_path(current_user.id)
  end

  private
  def settings_params
    params.require(:notification).permit(:is_required)
  end
end
