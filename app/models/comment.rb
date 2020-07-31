class Comment < ApplicationRecord
  has_one_attached :attachment
  belongs_to :question
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  validates :content, presence: true

  private

  def create_notifications
    notification = Notification.create(subject: self, team: question.task.drawing.team, action_type: :comment_to_question)
    NotificationRead.create(user_id: user.id, notification_id: notification.id)
  end
end
