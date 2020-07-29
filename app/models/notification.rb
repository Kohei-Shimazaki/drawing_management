class Notification < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :team

  enum action_type: {
    question_to_task: 0,
    comment_to_question: 1,
    task_approval_waiting: 2,
    task_completed: 3,
    chat_to_team: 4,
  }
  enum checked: {
    unchecked: false,
    checked: true
  }
end
