class Question < ApplicationRecord
  has_one_attached :attachment
  belongs_to :task, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  private

  def create_notifications
    Notification.create(subject: self, team: task.drawing.team, action_type: :comment_to_question)
  end
end
