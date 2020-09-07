# frozen_string_literal: true

class AddTeamRefToDrawings < ActiveRecord::Migration[5.2]
  def change
    add_reference :drawings, :team, foreign_key: true
  end
end
