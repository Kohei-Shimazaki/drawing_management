# frozen_string_literal: true

class AddCompanyRefCustomers < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :company, foreign_key: true
  end
end
