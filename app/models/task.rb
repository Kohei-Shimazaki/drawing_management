class Task < ApplicationRecord
  belongs_to :staff, class_name: 'User', foreign_key: :staff_id, optional: true
  belongs_to :approver, class_name: 'User', foreign_key: :approver_id, optional: true
  belongs_to :drawing
  belongs_to :revision, optional: true
  has_many :evidences, dependent: :destroy
  has_many :references, dependent: :destroy
  has_many :questions, dependent: :destroy
  validates :title, presence: true
  enum status: {
    waiting: 0, #未着手
    working: 1, #着手
    completed: 2, #完了
    pending: 3, #保留
    discontinued: 4, #中止
  }
end
