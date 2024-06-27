class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :wish_list, dependent: :destroy
  # Google 認証
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  # 通知用のテーブル
  has_one :notification, dependent: :destroy
  # お気に入り
  has_many :favorites
  has_many :favorite_wish_lists, through: :favorites, source: :wish_list, dependent: :destroy

  # 通知が必要なユーザーを取得するスコープ
  scope :required_notification, -> { joins(:notification).where(notification: { is_required: true }) }

  # 新しいデータもしくは crypted_password が変更された場合
  # 最低3文字のバリデーションを設定
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  # password_confirmation と一致するかのバリデーションを設定
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  # 値が空でない（nil や空文字でない）ようにバリデーションを設定
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  # 属性の値が一意であり重複していないようにバリデーションを設定
  # 値が空でない（nil や空文字でない）ようにバリデーションを設定
  # 255文字以内
  validates :email, uniqueness: true, presence: true, length: { maximum: 255 }

  # 値が空でない（nil や空文字でない）ようにバリデーションを設定
  # 50文字以内
  validates :name, presence: true, length: { maximum: 50 }

  # 属性の値が一意であり重複していないようにバリデーションを設定
  # nil は重複OK
  validates :reset_password_token, uniqueness: true, allow_nil: true

  # 引数のリストが自分のリストかどうか
  def my_list?(wish_list)
    wish_list.user_id == self.id
  end

  # 引数の wish が自分の wish かどうか
  def my_wish?(wish)
    wish.wish_list.user.id == self.id
  end

  # 引数の wish のタイトルと同じタイトルの wish が自分のリストにあるかどうか
  def included_my_list?(wish)
    wishes = self.wish_list.wishes
    wishes.pluck(:title).include?(wish.title)
  end

  # 引数のリストがユーザーのお気に入りかどうかを判定
  def favorite?(wish_list)
    wish_list.favorites.pluck(:user_id).include?(self.id)
  end

  # 引数のリストをお気に入りに追加
  def make_favorite(wish_list)
    favorite_wish_lists << wish_list
  end

  # 引数のリストをお気に入りから削除
  def delete_favorite(wish_list)
    favorite_wish_lists.delete(wish_list)
  end
end
