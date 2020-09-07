# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :phone_number
      t.string :location
      t.text :icon
      t.text :overview

      t.timestamps
    end
  end
end
