class Comment < ApplicationRecord
  has_one_attached :attachment
  belongs_to :question
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
end
