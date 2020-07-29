class Task < ApplicationRecord
  belongs_to :staff, class_name: 'User', foreign_key: :staff_id, optional: true
  belongs_to :approver, class_name: 'User', foreign_key: :approver_id, optional: true
  belongs_to :drawing
  belongs_to :revision, optional: true
  has_many :evidences, dependent: :destroy
  has_many :references, dependent: :destroy
  has_many :questions, dependent: :destroy
  validates :title, presence: true
  has_many :notifications, as: :subject, dependent: :destroy

  enum status: {
    waiting: 0, #未着手
    working: 1, #着手
    pending: 2, #保留
    discontinued: 3, #中止
    approval_waiting: 4, #承認待ち
    completed: 5, #完了
  }

  after_commit :create_notifications

  private

  def create_notifications
    binding.pry
    if self.approval_waiting?
      Notification.create(subject: self, team: drawing.team, action_type: :task_approval_waiting)
    elsif self.completed?
      Notification.create(subject: self, team: drawing.team, action_type: :task_completed)
    end
  end

end
