# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :staff, class_name: 'User', foreign_key: :staff_id, optional: true
  belongs_to :approver, class_name: 'User', foreign_key: :approver_id, optional: true
  belongs_to :drawing
  belongs_to :revision, optional: true
  has_many :evidences, dependent: :destroy
  has_many :references, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :notification, as: :subject, dependent: :destroy

  validates :title, presence: true, length: {maximum: 100}
  validates :deadline, presence: true
  validate :date_not_before_today

  enum status: {
    waiting: 0, # 未着手
    working: 1, # 着手
    pending: 2, # 保留
    discontinued: 3, # 中止
    approval_waiting: 4, # 承認待ち
    completed: 5, # 完了
    approval_rescission: 6 # 承認取り消し
  }

  after_commit :create_notifications

  private

  def date_not_before_today
    errors.add(:start_date, 'は今日以降のものを選択してください') if deadline.nil? || deadline <= Date.today - 1
  end

  def create_notifications
    if approval_waiting?
      notification = Notification.create(subject: self, team: drawing.team, action_type: :task_approval_waiting)
      NotificationRead.create(user_id: staff.id, notification_id: notification.id)
    elsif completed?
      notification = Notification.create(subject: self, team: drawing.team, action_type: :task_completed)
      NotificationRead.create(user_id: approver.id, notification_id: notification.id)
    elsif approval_rescission?
      notification = Notification.create(subject: self, team: drawing.team, action_type: :task_approval_rescission)
      NotificationRead.create(user_id: approver.id, notification_id: notification.id)
    end
  end
end
