class Message < ApplicationRecord
  belongs_to :user
  belongs_to :team
  after_create_commit { MessageBroadcastJob.perform_later self }

  after_create_commit :create_notifications

  private

  def create_notifications
    Notification.create(subject: self, team: team, action_type: :chat_to_team)
  end
end
