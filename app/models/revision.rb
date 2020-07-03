class Revision < ApplicationRecord
  belongs_to :drawing
  has_many :tasks, dependent: :destroy
  has_one_attached :content
end
