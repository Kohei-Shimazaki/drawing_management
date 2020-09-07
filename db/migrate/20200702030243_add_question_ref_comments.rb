# frozen_string_literal: true

class AddQuestionRefComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :question, foreign_key: true
  end
end
