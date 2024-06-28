class WishList < ApplicationRecord
  belongs_to :user
  has_many :wishes, dependent: :destroy
  # お気に入り
  has_many :favorites, dependent: :destroy

  # 値が空でない（nil や空文字でない）ようにバリデーションを設定
  # 最大255文字かつ未記入であることを許容しないバリデーションを設定
  validates :title, presence: true, length: { maximum: 255 }
  validates :granted_wish_rate, numericality: { in: 0..100 }

  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

  # granted_wish_rate を計算する
  def update_granted_wish_rate
    # リストの wish の数を取得
    wishes_count = wishes.count
    # wish が 0 なら 0 を返す
    return 0 if wishes.count.zero?
    # 達成している wish の数を取得
    granted_count = wishes.where(granted: true).size
    # データベースを更新
    self.update!(granted_wish_rate: (granted_count / wishes_count.to_f * 100).to_i)
  end

  # granted_wish_rate の値に応じてカラーを切り替え
  def rate_color
    case granted_wish_rate
    when 0..33
      "primary"
    when 34..66
      "secondary"
    when 67..100
      "accent"
    end
  end
end
