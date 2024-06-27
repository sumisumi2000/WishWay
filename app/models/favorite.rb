class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :wish_list

  validates :user_id, uniqueness: { scope: :wish_list_id }
end
