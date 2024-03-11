class CreateWishes < ActiveRecord::Migration[7.1]
  def change
    create_table :wishes do |t|
      t.string :title, null: false
      t.belongs_to :wish_lists, null: false, foreign_key: true

      t.timestamps
    end
  end
end
