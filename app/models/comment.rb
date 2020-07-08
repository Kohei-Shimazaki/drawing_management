class Comment < ApplicationRecord
  has_one_attached :attachment
  belongs_to :question
  belongs_to :user
end
