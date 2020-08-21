class Question < ApplicationRecord
  has_one_attached :attachment
  belongs_to :task, optional: true
  has_one :drawing, through: :task
  has_one :project, through: :drawing
  has_one :team, through: :drawing
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_one :notification, as: :subject, dependent: :destroy

  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true

  # after_create_commit :create_notifications

  private

    def create_notifications
      notification = Notification.create(subject: self, team: task.drawing.team, action_type: :question_to_task)
      NotificationRead.create(user_id: task.staff.id, notification_id: notification.id)
    end
end
