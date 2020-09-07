# frozen_string_literal: true

class AddTaskRefEvidences < ActiveRecord::Migration[5.2]
  def change
    add_reference :evidences, :task, foreign_key: true
  end
end
