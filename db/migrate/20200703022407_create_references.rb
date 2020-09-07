# frozen_string_literal: true

class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :references do |t|
      t.text :content
      t.text :comment
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
