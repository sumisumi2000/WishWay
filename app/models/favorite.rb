class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :wish_list
end
