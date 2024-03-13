class AddFrantedToWishes < ActiveRecord::Migration[7.1]
  def change
    add_column :wishes, :granted, :boolean, default: false, null: false
  end
end
