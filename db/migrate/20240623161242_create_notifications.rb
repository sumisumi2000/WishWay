class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.boolean :is_required, default: false, null: false
      t.belongs_to :user, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
