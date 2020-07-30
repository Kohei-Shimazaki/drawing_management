class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :subject, polymorphic: true
  belongs_to :team
  has_many :notification_reads, dependent: :destroy
  has_many :has_read_users, through: :notification_reads, source: :user

  enum action_type: {
    question_to_task: 0,
    comment_to_question: 1,
    task_approval_waiting: 2,
    task_completed: 3,
    chat_to_team: 4,
    task_approval_rescission: 5,
  }

  def redirect_path
    case action_type.to_sym
    when :question_to_task
      question_path(subject)
    when :comment_to_question
      question_path(subject.question)
    when :task_approval_waiting
      task_path(subject)
    when :task_completed
      task_path(subject)
    when :task_approval_rescission
      task_path(subject)
    when :chat_to_team
      chat_team_path(subject.team)
    end
  end
end
