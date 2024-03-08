class User < ApplicationRecord
  authenticates_with_sorcery!

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
end
