# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :team
  has_many :message_reads, dependent: :destroy
  has_many :has_read_users, through: :message_reads, source: :user

  validates :content, presence: true, length: {maximum: 140}

  after_create_commit { MessageBroadcastJob.perform_later self }
  after_create_commit :create_notifications

  private

  def create_notifications
    notification = Notification.create(subject: self, team: team, action_type: :chat_to_team)
    NotificationRead.create(user_id: user.id, notification_id: notification.id)
  end
end
