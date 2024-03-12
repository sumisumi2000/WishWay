class RenameWishListsIdColumnToWishes < ActiveRecord::Migration[7.1]
  def change
    rename_column :wishes, :wish_lists_id, :wish_list_id
  end
end
