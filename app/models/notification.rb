class Notification < ApplicationRecord
  belongs_to :user

  # true or false であるかどうかのバリデーションを設定
  validates :is_required, exclusion: [nil]

  # is_required カラムの状態に応じて対応する言葉を返す
  def is_required_status
    is_required ? 'ON' : 'OFF'
  end
end
