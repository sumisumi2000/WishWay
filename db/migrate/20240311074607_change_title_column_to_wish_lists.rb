class ChangeTitleColumnToWishLists < ActiveRecord::Migration[7.1]
  def change
    change_column_null :wish_lists, :title, true
  end
end
