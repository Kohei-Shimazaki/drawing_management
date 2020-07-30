class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast(
      "team_channel_#{notification.team_id}",
      notification: render_notification(notification),
      user_id: user_id(notification),
    )
  end

  private
    def render_notification(notification)
      renderer = ApplicationController.renderer.new(http_host: 'localhost:3000')
      renderer.render(partial: "notifications/#{notification.action_type}", locals: { notification: notification })
    end

    def user_id(notification)
      case notification.action_type.to_sym
      when :question_to_task
        notification.subject.staff.id
      when :comment_to_question
        notification.user.id
      when :task_approval_waiting
        notification.subject.staff.id
      when :task_completed
        notification.subject.approver.id
      when :task_approval_rescission
        notification.subject.approver.id
      when :chat_to_team
        notification.subject.user.id
      end
    end
end
