class AddGrantedWishRateToWishLists < ActiveRecord::Migration[7.1]
  def change
    add_column :wish_lists, :granted_wish_rate, :integer, default: 0, null: false
  end
end
