# frozen_string_literal: true

class AddProjectRefDrawings < ActiveRecord::Migration[5.2]
  def change
    add_reference :drawings, :project, foreign_key: true
  end
end
