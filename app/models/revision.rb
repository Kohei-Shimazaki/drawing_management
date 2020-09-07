# frozen_string_literal: true

class Revision < ApplicationRecord
  belongs_to :drawing
  has_many :tasks, dependent: :destroy
  has_one_attached :content

  validate :content_presence
  validates :revision_number, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  def content_presence
    errors.add(:content, 'がありません') unless content.attached?
  end
end
