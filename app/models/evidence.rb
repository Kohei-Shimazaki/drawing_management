# frozen_string_literal: true

class Evidence < ApplicationRecord
  has_one_attached :content
  belongs_to :task

  validates :comment, presence: true
end
