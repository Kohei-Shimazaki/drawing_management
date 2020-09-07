# frozen_string_literal: true

class AddCustomerRefProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :customer, foreign_key: true
  end
end
