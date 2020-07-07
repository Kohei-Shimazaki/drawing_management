class Question < ApplicationRecord
  has_one_attached :attachment
  belongs_to :task, optional: true
  has_many :comments, dependent: :destroy
end
