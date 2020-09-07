# frozen_string_literal: true

class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :employee_number, :integer
    add_column :users, :icon, :text
  end
end
