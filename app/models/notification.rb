class Notification < ApplicationRecord
  belongs_to :user

  # is_required カラムの状態に応じて対応する言葉を返す
  def is_required_status
    is_required ? 'ON' : 'OFF'
  end
end
