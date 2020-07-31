class Revision < ApplicationRecord
  belongs_to :drawing
  has_many :tasks, dependent: :destroy
  has_one_attached :content

  validate :content_presence

  def content_presence
    unless content.attached?
      errors.add(:content, 'がありません')
    end
  end
end
