class WishList < ApplicationRecord
  belongs_to :user
  has_many :wishes, dependent: :destroy
  # お気に入り
  has_many :favorites, dependent: :destroy

  # 値が空でない（nil や空文字でない）ようにバリデーションを設定
  # 最大255文字かつ未記入であることを許容しないバリデーションを設定
  validates :title, presence: true, length: { maximum: 255 }

  def self.ransackable_attributes(auth_object = nil)
    ["title"]
  end

end
