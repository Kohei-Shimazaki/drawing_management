class Like < ApplicationRecord
  belongs_to :user
  belongs_to :question, optional: true
  belongs_to :comment, optional: true
  has_one :notification, as: :subject, dependent: :destroy
end
