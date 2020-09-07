# frozen_string_literal: true

class Project < ApplicationRecord
  belongs_to :customer
  has_many :drawings
  has_many :tasks, through: :drawings
  has_many :questions, through: :tasks

  validates :name, presence: true, length: {maximum: 100}
end
