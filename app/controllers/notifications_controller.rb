class NotificationsController < ApplicationController
  def edit; end

  def update
    # 通知の有無を更新
    current_user.notification.update(settings_params)
  end

  private
  def settings_params
    params.require(:notification).permit(:is_required)
  end
end
