class Task < ApplicationRecord

  validates :title, presence: true
  enum status: {
    waiting: 0, #未着手
    working: 1, #着手
    completed: 2, #完了
    pending: 3, #保留
    discontinued: 4, #中止
  }
end
