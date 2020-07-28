class ChangeColumnToNotification < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :notifications, :users
    remove_index :notifications, :user_id
    remove_reference :notifications, :user
    add_reference :notifications, :team, foreign_key: true
  end
end
