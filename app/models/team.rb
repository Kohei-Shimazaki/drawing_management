# frozen_string_literal: true

class Team < ApplicationRecord
  has_one_attached :icon
  belongs_to :company
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  has_many :team_assigns, dependent: :destroy
  has_many :members, through: :team_assigns, source: :user
  has_many :messages, dependent: :destroy
  has_many :drawings, dependent: :destroy
  has_many :tasks, through: :dtawings
  has_many :questions, through: :tasks
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, length: {maximum: 100}
end
