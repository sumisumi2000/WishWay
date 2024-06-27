class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wish_list, null: false, foreign_key: true

      t.timestamps
    end
    add_index :favorites, [:user_id, :wish_list_id], unique: true
  end
end
