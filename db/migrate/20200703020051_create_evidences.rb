# frozen_string_literal: true

class CreateEvidences < ActiveRecord::Migration[5.2]
  def change
    create_table :evidences do |t|
      t.text :content
      t.text :comment

      t.timestamps
    end
  end
end
