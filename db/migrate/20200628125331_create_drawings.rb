# frozen_string_literal: true

class CreateDrawings < ActiveRecord::Migration[5.2]
  def change
    create_table :drawings do |t|
      t.string :title
      t.integer :drawing_number
      t.text :explanation

      t.timestamps
    end
  end
end
