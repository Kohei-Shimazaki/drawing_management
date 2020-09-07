# frozen_string_literal: true

class AddRefUserComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :user, foreign_key: true
  end
end
