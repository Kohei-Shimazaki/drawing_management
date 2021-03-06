# frozen_string_literal: true

class AddUserRefTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :staff, foreign_key: { to_table: :users }
    add_reference :tasks, :approver, foreign_key: { to_table: :users }
  end
end
