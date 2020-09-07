# frozen_string_literal: true

class AddUserAndTeamRefMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :user, foreign_key: true
    add_reference :messages, :team, foreign_key: true
  end
end
