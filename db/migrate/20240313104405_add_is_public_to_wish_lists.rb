class AddIsPublicToWishLists < ActiveRecord::Migration[7.1]
  def change
    add_column :wish_lists, :is_public, :boolean, default: true, null: false
  end
end
