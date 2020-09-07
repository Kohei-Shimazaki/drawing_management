# frozen_string_literal: true

class AddOwnerRefTeams < ActiveRecord::Migration[5.2]
  def change
    add_reference :teams, :owner, foreign_key: { to_table: :users }
  end
end
