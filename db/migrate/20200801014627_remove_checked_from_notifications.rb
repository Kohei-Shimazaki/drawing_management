# frozen_string_literal: true

class RemoveCheckedFromNotifications < ActiveRecord::Migration[5.2]
  def up
    remove_column :notifications, :checked
  end

  def down
    add_column :notifications, :checked, :boolean
  end
end
